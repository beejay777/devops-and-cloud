# Assignment: Linux Basics for DevOps and Cloud

## Important Instructions

Complete all tasks using the Linux terminal.

Use these exact paths:

```bash
/workspace/devops-linux-lab
/answers
```

Before starting, run:

```bash
sudo mkdir -p /workspace/devops-linux-lab
sudo mkdir -p /answers
sudo chmod -R 777 /workspace /answers
cd /workspace/devops-linux-lab
```

Do not change file names, folder names, or output locations.

## Task 1: Directory Structure

Create this directory structure:

```text
/workspace/devops-linux-lab/
├── configs
├── logs
├── scripts
├── notes
├── backup
└── temp
```

Save this command output to `/answers/tree.txt`:

```bash
find /workspace/devops-linux-lab -maxdepth 2 -type d | sort
```

## Task 2: Navigation Output

Go to `/workspace/devops-linux-lab`.

Save the output of these commands into `/answers/navigation.txt`:

```bash
pwd
ls -la
```

## Task 3: Configuration File

Create:

```bash
/workspace/devops-linux-lab/configs/app.conf
```

The file must contain exactly:

```text
APP_NAME=student-portal
ENV=dev
PORT=8080
LOG_LEVEL=info
```

Save the output of this command to `/answers/config-output.txt`:

```bash
cat /workspace/devops-linux-lab/configs/app.conf
```

## Task 4: Notes File

Create:

```bash
/workspace/devops-linux-lab/notes/linux-notes.txt
```

The file must contain exactly 5 lines:

```text
Linux is used in DevOps.
Linux servers run most cloud applications.
Logs are used for troubleshooting.
Shell scripts help in automation.
File permissions are important for security.
```

Save the number of lines to `/answers/notes-line-count.txt`:

```bash
wc -l /workspace/devops-linux-lab/notes/linux-notes.txt
```

## Task 5: Log File and Grep

Create:

```bash
/workspace/devops-linux-lab/logs/app.log
```

The file must contain exactly:

```text
INFO Application started
INFO User login successful
WARNING Disk usage above 80 percent
ERROR Database connection failed
INFO Backup completed
ERROR Application crashed
```

Save only `ERROR` lines to `/answers/error-logs.txt`.

Save only `WARNING` lines to `/answers/warning-logs.txt`.

Use `grep`.

## Task 6: Tail Command

Save the last 3 lines of `/workspace/devops-linux-lab/logs/app.log` to:

```bash
/answers/last-three-logs.txt
```

Use `tail`.

## Task 7: Copy, Move, and Delete

Copy:

```bash
/workspace/devops-linux-lab/configs/app.conf
```

to:

```bash
/workspace/devops-linux-lab/backup/app.conf.bak
```

Create:

```bash
/workspace/devops-linux-lab/notes/draft.txt
```

Write this inside it:

```text
This is my Linux draft note.
```

Move it to:

```bash
/workspace/devops-linux-lab/notes/final-note.txt
```

Create:

```bash
/workspace/devops-linux-lab/temp/remove-me.txt
```

Then delete it.

Save this command output to `/answers/file-check.txt`:

```bash
find /workspace/devops-linux-lab -type f | sort
```

## Task 8: Find Command

Find all `.conf` files inside `/workspace/devops-linux-lab` and save the result to:

```bash
/answers/find-conf.txt
```

Use the `find` command.

## Task 9: Script Creation and Permission

Create:

```bash
/workspace/devops-linux-lab/scripts/deploy.sh
```

The script must contain:

```bash
#!/bin/bash
echo "Deploying student-portal on port 8080"
echo "Deployment finished"
```

Give execute permission to the script.

Save permission output to `/answers/deploy-permission.txt`:

```bash
ls -l /workspace/devops-linux-lab/scripts/deploy.sh
```

Run the script and save its output to:

```bash
/answers/deploy-output.txt
```

## Task 10: Health Check Script

Create:

```bash
/workspace/devops-linux-lab/scripts/health-check.sh
```

The script must print these headings:

```text
System Health Check
Current User:
Hostname:
Disk Usage:
Memory Usage:
System Uptime:
```

The script must also run suitable Linux commands below each heading.

Use these commands inside the script:

```bash
whoami
hostname
df -h
free -h
uptime
```

Give execute permission to the script.

Run the script and save its output to:

```bash
/answers/health-check-output.txt
```

## Task 11: System Information

Save the output of these commands to `/answers/system-info.txt`:

```bash
whoami
hostname
uname -a
df -h
free -h
uptime
```

## Task 12: Process Management

Run this command in the background:

```bash
sleep 300 &
```

Save its process ID to:

```bash
/answers/sleep.pid
```

Save the process information to:

```bash
/answers/process-info.txt
```

Use:

```bash
ps -p <PID>
```

Then kill the process.

After killing it, create:

```bash
/answers/process-killed.txt
```

The file must contain exactly:

```text
DONE
```

## Task 13: Sorting and Unique Values

Create:

```bash
/workspace/devops-linux-lab/notes/users.txt
```

The file must contain:

```text
ram
sita
hari
ram
gita
sita
```

Sort the names and remove duplicates.

Save the final output to:

```bash
/answers/unique-users.txt
```

Expected output:

```text
gita
hari
ram
sita
```

## Task 14: Archive and Backup

Create a compressed archive named:

```bash
/workspace/devops-linux-lab/backup/devops-lab.tar.gz
```

The archive must include these folders:

```text
configs
scripts
notes
logs
```

Save the archive content list to:

```bash
/answers/archive-list.txt
```

Use:

```bash
tar -tzf /workspace/devops-linux-lab/backup/devops-lab.tar.gz
```

## Task 15: Final Summary File

Create:

```bash
/answers/final-summary.txt
```

It must contain exactly:

```text
Linux assignment completed.
I created files, directories, logs, scripts, permissions, process outputs, and backup archive.
```

## Final Submission

Submit:

1. Screenshot of the checker output.
2. The `/answers` folder.
3. The `/workspace/devops-linux-lab` folder.

