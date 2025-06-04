package github.block_secrets

deny[msg] {
  some i
  step := input.jobs[_].steps[i]
  contains(step.run, "AWS_SECRET")
  msg := "Workflow contains potential hardcoded secret reference"
}
