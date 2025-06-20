# Branch Protection Configuration

To ensure code quality and require CI checks before merging, apply these branch protection rules to the `master` branch:

## GitHub Repository Settings → Branches → Add Rule

### Branch name pattern
```
master
```

### Required Settings

#### ✅ Require a pull request before merging
- [x] Require approvals: **1** (or 0 if you're the only contributor)
- [x] Dismiss stale PR approvals when new commits are pushed
- [x] Require review from code owners (if you create a CODEOWNERS file)

#### ✅ Require status checks to pass before merging
- [x] Require branches to be up to date before merging
- **Required status checks:**
  - `test` (from the CI workflow)

#### ✅ Require conversation resolution before merging
- [x] All conversations on code must be resolved

#### ✅ Require signed commits (optional but recommended)
- [x] Require signed commits

#### ✅ Require linear history (optional)
- [x] Require linear history (prevents merge commits)

#### ✅ Include administrators
- [x] Include administrators (applies rules to repo admins too)

## How to Apply These Settings

1. Go to your GitHub repository
2. Click **Settings** tab
3. Click **Branches** in the left sidebar
4. Click **Add rule** button
5. Enter `master` as the branch name pattern
6. Check all the boxes listed above
7. Click **Create** to save the rule

## Result

After applying these settings:
- All changes to `master` must go through a pull request
- The CI workflow must pass before merging is allowed
- No direct pushes to `master` are permitted
- Code quality is enforced automatically

## Testing the Setup

1. Create a new branch and make a test change
2. Open a pull request
3. Verify that the CI checks run automatically
4. Confirm that merging is blocked until checks pass