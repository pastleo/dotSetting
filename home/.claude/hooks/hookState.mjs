#!/usr/bin/env node

import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs';
import { join } from 'path';

export function createHookState(cwd) {
  const localDir = join(cwd, '.local');
  const stateFile = join(localDir, 'hook-state.json');

  function get() {
    try {
      if (existsSync(stateFile)) {
        return JSON.parse(readFileSync(stateFile, 'utf-8'));
      }
    } catch {}
    return {};
  }

  function save(state) {
    if (!existsSync(localDir)) {
      mkdirSync(localDir, { recursive: true });
    }
    writeFileSync(stateFile, JSON.stringify(state, null, 2));
  }

  function exists() {
    return existsSync(stateFile);
  }

  return { get, save, exists, stateFile };
}
