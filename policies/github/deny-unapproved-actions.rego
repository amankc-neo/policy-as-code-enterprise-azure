package github.deny_unapproved_actions

approved_actions = {
  "actions/checkout@v3",
  "actions/setup-node@v3",
  "github/codeql-action/init@v2"
}

deny[msg] {
  action := input.jobs[_].steps[_].uses
  not approved_actions[action]
  msg := sprintf("Action '%s' is not approved", [action])
}
