locals {
  users = csvdecode(file("sample.csv"))
}