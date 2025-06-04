package kubernetes.enforce_labels

required_labels = {"app", "env"}

deny[msg] {
  some label
  label = required_labels[_]
  not input.metadata.labels[label]
  msg := sprintf("Missing required label: %s", [label])
}
