package kubernetes.disallow_latest

deny[msg] {
  input.spec.template.spec.containers[_].image == img
  endswith(img, ":latest")
  msg := "Usage of 'latest' tag is not allowed"
}
