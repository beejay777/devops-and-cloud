# Linux Basics Lab for DevOps and Cloud

This repository contains a practical Linux assignment for beginner DevOps and Cloud students.

Students should complete the assignment on their own computer, then run the checker script to self-test their work before submitting.

## What You Will Practice

- Linux file and folder navigation
- File creation, copy, move, and delete
- Text handling with `cat`, `grep`, `wc`, `tail`, and `sort`
- Log filtering
- File permissions
- Shell scripts
- System information commands
- Process management
- Backup archive creation

## Required System

Use any one of the following:

- Ubuntu/Linux
- WSL on Windows
- Linux virtual machine
- Cloud Linux server

Required commands:

```bash
bash mkdir touch cat grep find wc tail chmod ps kill tar sort uniq
```

## Step 1: Clone This Repository

```bash
git clone https://github.com/beejay777/devops-and-cloud.git
cd devops-and-cloud
```


## Step 2: Read the Assignment

Open:

```bash
assignment.md
```

Complete all tasks exactly as instructed.

Your lab work must be inside:

```bash
/workspace/devops-linux-lab
```

Your answer/output files must be inside:

```bash
/answers
```

## Step 3: Prepare Folders

Run this before starting the assignment:

```bash
sudo mkdir -p /workspace/devops-linux-lab
sudo mkdir -p /answers
sudo chmod -R 777 /workspace /answers
```

Then go to the lab folder:

```bash
cd /workspace/devops-linux-lab
```

## Step 4: Complete the Assignment

Complete all tasks given in `assignment.md`.

Do not rename files or folders.

Do not save outputs in a different location.

The checker script expects the exact paths used in the assignment.

## Step 5: Run the Self-Checker

After completing the assignment, return to this repository folder:

```bash
cd devops-linux-basics-lab
```

Make the checker executable:

```bash
chmod +x scripts/check-assignment.sh
```

Run the checker:

```bash
./scripts/check-assignment.sh
```

You can also run it using:

```bash
bash scripts/check-assignment.sh
```

## Step 6: Understand the Result

The checker will show:

```text
PASS
FAIL
Final Score
```

If you see `FAIL`, read the message carefully and fix that part of your assignment.

After fixing, run the checker again.

## Optional: Use Custom Paths

By default, the checker uses:

```bash
LAB_DIR=/workspace/devops-linux-lab
ANSWERS_DIR=/answers
```

If your teacher allows a different path, run:

```bash
LAB_DIR=/your/lab/path ANSWERS_DIR=/your/answers/path ./scripts/check-assignment.sh
```

Use the default paths unless your teacher has clearly told you otherwise.

## Submission

Submit:

1. Screenshot of the checker output.
2. Your `/answers` folder.
3. Your `/workspace/devops-linux-lab` folder.

## Warning

Only work inside:

```bash
/workspace/devops-linux-lab
/answers
```

Do not run dangerous commands such as:

```bash
rm -rf /
sudo rm -rf /*
```

