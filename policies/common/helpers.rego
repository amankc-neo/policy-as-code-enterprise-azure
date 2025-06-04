package common.helpers

is_empty(x) = true {
  count(x) == 0
}

is_empty(x) = false {
  count(x) > 0
}
