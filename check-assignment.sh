#!/usr/bin/env bash

set -u

LAB_DIR="${LAB_DIR:-/workspace/devops-linux-lab}"
ANSWERS_DIR="${ANSWERS_DIR:-/answers}"

PASS_COUNT=0
FAIL_COUNT=0
CHECK_COUNT=0

green=""
red=""
yellow=""
reset=""

if [ -t 1 ]; then
  green="$(printf '\033[32m')"
  red="$(printf '\033[31m')"
  yellow="$(printf '\033[33m')"
  reset="$(printf '\033[0m')"
fi

pass() {
  CHECK_COUNT=$((CHECK_COUNT + 1))
  PASS_COUNT=$((PASS_COUNT + 1))
  printf "%sPASS%s: %s\n" "$green" "$reset" "$1"
}

fail() {
  CHECK_COUNT=$((CHECK_COUNT + 1))
  FAIL_COUNT=$((FAIL_COUNT + 1))
  printf "%sFAIL%s: %s\n" "$red" "$reset" "$1"
}

info() {
  printf "%sINFO%s: %s\n" "$yellow" "$reset" "$1"
}

check_dir() {
  local path="$1"
  if [ -d "$path" ]; then
    pass "Directory exists: $path"
  else
    fail "Directory missing: $path"
  fi
}

check_file() {
  local path="$1"
  if [ -f "$path" ]; then
    pass "File exists: $path"
  else
    fail "File missing: $path"
  fi
}

check_executable() {
  local path="$1"
  if [ -x "$path" ]; then
    pass "Executable permission set: $path"
  else
    fail "Executable permission missing: $path"
  fi
}

check_contains() {
  local path="$1"
  local text="$2"
  local label="$3"

  if [ -f "$path" ] && grep -Fq "$text" "$path"; then
    pass "$label"
  else
    fail "$label"
  fi
}

check_exact_file() {
  local path="$1"
  local expected="$2"
  local label="$3"
  local tmp

  tmp="$(mktemp)"
  printf "%s" "$expected" > "$tmp"

  if [ -f "$path" ] && cmp -s "$tmp" "$path"; then
    pass "$label"
  else
    fail "$label"
    if [ -f "$path" ]; then
      info "Expected content for $path does not match exactly."
    fi
  fi

  rm -f "$tmp"
}

check_command_output_contains() {
  local path="$1"
  local command_text="$2"
  local label="$3"

  if [ -f "$path" ] && grep -Fq "$command_text" "$path"; then
    pass "$label"
  else
    fail "$label"
  fi
}

print_header() {
  printf "\n%s\n" "=================================================="
  printf "%s\n" "$1"
  printf "%s\n" "=================================================="
}

print_header "Linux Basics Lab Self-Check"
info "Lab directory: $LAB_DIR"
info "Answers directory: $ANSWERS_DIR"

print_header "Task 1: Directory Structure"
check_dir "$LAB_DIR/configs"
check_dir "$LAB_DIR/logs"
check_dir "$LAB_DIR/scripts"
check_dir "$LAB_DIR/notes"
check_dir "$LAB_DIR/backup"
check_dir "$LAB_DIR/temp"
check_file "$ANSWERS_DIR/tree.txt"
check_contains "$ANSWERS_DIR/tree.txt" "$LAB_DIR/configs" "tree.txt includes configs directory"
check_contains "$ANSWERS_DIR/tree.txt" "$LAB_DIR/logs" "tree.txt includes logs directory"

print_header "Task 2: Navigation Output"
check_file "$ANSWERS_DIR/navigation.txt"
check_contains "$ANSWERS_DIR/navigation.txt" "$LAB_DIR" "navigation.txt includes working directory path"
check_contains "$ANSWERS_DIR/navigation.txt" "configs" "navigation.txt includes directory listing"

print_header "Task 3: Configuration File"
APP_CONF_EXPECTED='APP_NAME=student-portal
ENV=dev
PORT=8080
LOG_LEVEL=info
'
check_file "$LAB_DIR/configs/app.conf"
check_exact_file "$LAB_DIR/configs/app.conf" "$APP_CONF_EXPECTED" "app.conf content is exactly correct"
check_file "$ANSWERS_DIR/config-output.txt"
check_exact_file "$ANSWERS_DIR/config-output.txt" "$APP_CONF_EXPECTED" "config-output.txt content is exactly correct"

print_header "Task 4: Notes File"
NOTES_EXPECTED='Linux is used in DevOps.
Linux servers run most cloud applications.
Logs are used for troubleshooting.
Shell scripts help in automation.
File permissions are important for security.
'
check_file "$LAB_DIR/notes/linux-notes.txt"
check_exact_file "$LAB_DIR/notes/linux-notes.txt" "$NOTES_EXPECTED" "linux-notes.txt content is exactly correct"
check_file "$ANSWERS_DIR/notes-line-count.txt"
check_contains "$ANSWERS_DIR/notes-line-count.txt" "5" "notes-line-count.txt shows 5 lines"

print_header "Task 5: Log File and Grep"
APP_LOG_EXPECTED='INFO Application started
INFO User login successful
WARNING Disk usage above 80 percent
ERROR Database connection failed
INFO Backup completed
ERROR Application crashed
'
ERROR_EXPECTED='ERROR Database connection failed
ERROR Application crashed
'
WARNING_EXPECTED='WARNING Disk usage above 80 percent
'
check_file "$LAB_DIR/logs/app.log"
check_exact_file "$LAB_DIR/logs/app.log" "$APP_LOG_EXPECTED" "app.log content is exactly correct"
check_file "$ANSWERS_DIR/error-logs.txt"
check_exact_file "$ANSWERS_DIR/error-logs.txt" "$ERROR_EXPECTED" "error-logs.txt contains only ERROR lines"
check_file "$ANSWERS_DIR/warning-logs.txt"
check_exact_file "$ANSWERS_DIR/warning-logs.txt" "$WARNING_EXPECTED" "warning-logs.txt contains only WARNING line"

print_header "Task 6: Tail Command"
LAST_THREE_EXPECTED='ERROR Database connection failed
INFO Backup completed
ERROR Application crashed
'
check_file "$ANSWERS_DIR/last-three-logs.txt"
check_exact_file "$ANSWERS_DIR/last-three-logs.txt" "$LAST_THREE_EXPECTED" "last-three-logs.txt contains last 3 lines"

print_header "Task 7: Copy, Move, and Delete"
check_file "$LAB_DIR/backup/app.conf.bak"
check_exact_file "$LAB_DIR/backup/app.conf.bak" "$APP_CONF_EXPECTED" "backup app.conf.bak content is correct"
check_file "$LAB_DIR/notes/final-note.txt"
check_exact_file "$LAB_DIR/notes/final-note.txt" "This is my Linux draft note.
" "final-note.txt content is correct"
if [ ! -f "$LAB_DIR/notes/draft.txt" ]; then
  pass "draft.txt was moved"
else
  fail "draft.txt still exists"
fi
if [ ! -f "$LAB_DIR/temp/remove-me.txt" ]; then
  pass "remove-me.txt was deleted"
else
  fail "remove-me.txt still exists"
fi
check_file "$ANSWERS_DIR/file-check.txt"
check_contains "$ANSWERS_DIR/file-check.txt" "$LAB_DIR/notes/final-note.txt" "file-check.txt includes final-note.txt"

print_header "Task 8: Find Command"
check_file "$ANSWERS_DIR/find-conf.txt"
check_contains "$ANSWERS_DIR/find-conf.txt" "$LAB_DIR/configs/app.conf" "find-conf.txt includes app.conf"

print_header "Task 9: Deploy Script"
DEPLOY_EXPECTED='#!/bin/bash
echo "Deploying student-portal on port 8080"
echo "Deployment finished"
'
DEPLOY_OUTPUT_EXPECTED='Deploying student-portal on port 8080
Deployment finished
'
check_file "$LAB_DIR/scripts/deploy.sh"
check_exact_file "$LAB_DIR/scripts/deploy.sh" "$DEPLOY_EXPECTED" "deploy.sh content is exactly correct"
check_executable "$LAB_DIR/scripts/deploy.sh"
check_file "$ANSWERS_DIR/deploy-permission.txt"
check_contains "$ANSWERS_DIR/deploy-permission.txt" "x" "deploy-permission.txt shows execute permission"
check_file "$ANSWERS_DIR/deploy-output.txt"
check_exact_file "$ANSWERS_DIR/deploy-output.txt" "$DEPLOY_OUTPUT_EXPECTED" "deploy-output.txt is correct"

print_header "Task 10: Health Check Script"
check_file "$LAB_DIR/scripts/health-check.sh"
check_executable "$LAB_DIR/scripts/health-check.sh"
check_file "$ANSWERS_DIR/health-check-output.txt"
check_contains "$ANSWERS_DIR/health-check-output.txt" "System Health Check" "health-check output includes title"
check_contains "$ANSWERS_DIR/health-check-output.txt" "Current User:" "health-check output includes Current User"
check_contains "$ANSWERS_DIR/health-check-output.txt" "Hostname:" "health-check output includes Hostname"
check_contains "$ANSWERS_DIR/health-check-output.txt" "Disk Usage:" "health-check output includes Disk Usage"
check_contains "$ANSWERS_DIR/health-check-output.txt" "Memory Usage:" "health-check output includes Memory Usage"
check_contains "$ANSWERS_DIR/health-check-output.txt" "System Uptime:" "health-check output includes System Uptime"

print_header "Task 11: System Information"
check_file "$ANSWERS_DIR/system-info.txt"
check_contains "$ANSWERS_DIR/system-info.txt" "Linux" "system-info.txt includes uname output"
check_contains "$ANSWERS_DIR/system-info.txt" "Filesystem" "system-info.txt includes df output"

print_header "Task 12: Process Management"
check_file "$ANSWERS_DIR/sleep.pid"
check_file "$ANSWERS_DIR/process-info.txt"
check_contains "$ANSWERS_DIR/process-info.txt" "PID" "process-info.txt includes ps header"
check_file "$ANSWERS_DIR/process-killed.txt"
check_exact_file "$ANSWERS_DIR/process-killed.txt" "DONE
" "process-killed.txt contains DONE"

print_header "Task 13: Sorting and Unique Values"
USERS_EXPECTED='ram
sita
hari
ram
gita
sita
'
UNIQUE_USERS_EXPECTED='gita
hari
ram
sita
'
check_file "$LAB_DIR/notes/users.txt"
check_exact_file "$LAB_DIR/notes/users.txt" "$USERS_EXPECTED" "users.txt content is exactly correct"
check_file "$ANSWERS_DIR/unique-users.txt"
check_exact_file "$ANSWERS_DIR/unique-users.txt" "$UNIQUE_USERS_EXPECTED" "unique-users.txt output is correct"

print_header "Task 14: Archive and Backup"
check_file "$LAB_DIR/backup/devops-lab.tar.gz"
if [ -f "$LAB_DIR/backup/devops-lab.tar.gz" ] && tar -tzf "$LAB_DIR/backup/devops-lab.tar.gz" >/dev/null 2>&1; then
  pass "Archive is readable: devops-lab.tar.gz"
else
  fail "Archive is not readable: devops-lab.tar.gz"
fi
check_file "$ANSWERS_DIR/archive-list.txt"
check_command_output_contains "$ANSWERS_DIR/archive-list.txt" "configs" "archive-list.txt includes configs"
check_command_output_contains "$ANSWERS_DIR/archive-list.txt" "scripts" "archive-list.txt includes scripts"
check_command_output_contains "$ANSWERS_DIR/archive-list.txt" "notes" "archive-list.txt includes notes"
check_command_output_contains "$ANSWERS_DIR/archive-list.txt" "logs" "archive-list.txt includes logs"

print_header "Task 15: Final Summary"
FINAL_SUMMARY_EXPECTED='Linux assignment completed.
I created files, directories, logs, scripts, permissions, process outputs, and backup archive.
'
check_file "$ANSWERS_DIR/final-summary.txt"
check_exact_file "$ANSWERS_DIR/final-summary.txt" "$FINAL_SUMMARY_EXPECTED" "final-summary.txt content is exactly correct"

print_header "Final Result"
printf "Total checks: %s\n" "$CHECK_COUNT"
printf "Passed: %s\n" "$PASS_COUNT"
printf "Failed: %s\n" "$FAIL_COUNT"

if [ "$CHECK_COUNT" -gt 0 ]; then
  SCORE=$((PASS_COUNT * 100 / CHECK_COUNT))
else
  SCORE=0
fi

printf "Score: %s%%\n" "$SCORE"

if [ "$FAIL_COUNT" -eq 0 ]; then
  printf "%sAll checks passed. Great work.%s\n" "$green" "$reset"
  exit 0
else
  printf "%sSome checks failed. Fix the failed items and run the checker again.%s\n" "$red" "$reset"
  exit 1
fi

