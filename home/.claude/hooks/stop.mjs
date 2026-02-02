#!/usr/bin/env node

import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import { createHookState } from './hookState.mjs';

// Read stdin for hook input
const input = JSON.parse(readFileSync(0, 'utf-8'));
const { session_id, cwd } = input;

const hookState = createHookState(cwd);

// Extract content between markers from a file
function extractMarkerContent(filePath, startMarker, endMarker) {
  try {
    if (!existsSync(filePath)) return '';
    const content = readFileSync(filePath, 'utf-8');
    const regex = new RegExp(`${startMarker}([\\s\\S]*?)${endMarker}`);
    const match = content.match(regex);
    return match ? match[1].trim() : '';
  } catch {
    return '';
  }
}

// ===== Features =====

// Feature: Stop reminder
function stopReminder(state) {
  const shownSessions = state.stopReminderShown || [];

  // Check if already shown for this session
  if (session_id && shownSessions.includes(session_id)) {
    return null;
  }

  // Collect reminders from AGENTS files
  const reminders = [];

  const localReminder = extractMarkerContent(
    join(cwd, 'AGENTS.local.md'),
    '<!-- Stop hook reminder start -->',
    '<!-- Stop hook reminder end -->'
  );
  if (localReminder) reminders.push(localReminder);

  const agentsReminder = extractMarkerContent(
    join(cwd, 'AGENTS.md'),
    '<!-- Stop hook reminder start -->',
    '<!-- Stop hook reminder end -->'
  );
  if (agentsReminder) reminders.push(agentsReminder);

  if (reminders.length > 0) {
    // Mark as shown
    if (session_id) {
      shownSessions.push(session_id);
      state.stopReminderShown = shownSessions.slice(-100);
    }
    return reminders.join('\n\n');
  }

  return null;
}

// ===== Main =====

const state = hookState.get();
const messages = [];

// Run all features
const reminderMsg = stopReminder(state);
if (reminderMsg) messages.push(reminderMsg);

// Save state and output
hookState.save(state);

if (messages.length > 0) {
  console.log(JSON.stringify({
    decision: 'block',
    reason: messages.join('\n\n---\n\n')
  }));
}
