// random_string.tf
resource "random_string" "My-random-string" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric  = true
}
