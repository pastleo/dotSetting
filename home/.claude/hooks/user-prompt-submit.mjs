#!/usr/bin/env node

import { readFileSync } from 'fs';
import { createHookState } from './hookState.mjs';

// Read stdin for hook input
const input = JSON.parse(readFileSync(0, 'utf-8'));
const { session_id, cwd } = input;

const hookState = createHookState(cwd);

// ===== Features =====

// Feature: Reset stop reminder flag so it shows again after this prompt
function resetStopReminder(state) {
  if (!session_id) return;

  const shownSessions = state.stopReminderShown || [];
  state.stopReminderShown = shownSessions.filter(id => id !== session_id);
}

// ===== Main =====

if (hookState.exists()) {
  const state = hookState.get();

  // Run all features
  resetStopReminder(state);

  hookState.save(state);
}
