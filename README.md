```
# User Management Automation

A Bash script that automates Linux user account management. Create users, assign groups, lock/unlock accounts, generate reports, and delete users from the command line.

## Commands

- `create` - Creates a new user, assigns them to a group (creates the group if it doesn't exist), and generates a temporary password
- `lock` - Locks a user account to prevent login
- `unlock` - Unlocks a previously locked account
- `delete` - Removes a user and their home directory
- `report` - Lists all real users on the system with their groups and account status

## Usage

```
sudo bash user_manage.sh create <username> <groupname>
sudo bash user_manage.sh lock <username>
sudo bash user_manage.sh unlock <username>
sudo bash user_manage.sh delete <username>
sudo bash user_manage.sh report
```

## Example

```
sudo bash user_manage.sh create john developers
sudo bash user_manage.sh report
sudo bash user_manage.sh lock john
sudo bash user_manage.sh report
sudo bash user_manage.sh unlock john
sudo bash user_manage.sh delete john
```

## What I would improve

- Accept a CSV file to create multiple users at once
- Add logging so all actions are recorded with timestamps
- Email the temporary password to the user instead of printing it
- Add password expiry so users must change the temporary password on first login
- Add input validation to check for empty arguments before running

## Built with

Bash, useradd, usermod, userdel, groupadd, chpasswd, openssl, awk. Second project in a DevOps learning roadmap.
