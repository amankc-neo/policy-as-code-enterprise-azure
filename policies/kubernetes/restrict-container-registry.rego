package kubernetes.restrict_registry

default allow = false

allow {
  startswith(input.spec.template.spec.containers[_].image, "ghcr.io/")
}

deny[msg] {
  not allow
  msg := "Container images must come from ghcr.io registry only"
}
