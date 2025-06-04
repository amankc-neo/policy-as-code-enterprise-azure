package terraform.enforce_region

approved_regions = {"eastus", "westeurope", "centralindia"}

deny[msg] {
  input.resource[_].provider_config.region == region
  not approved_regions[region]
  msg := sprintf("Region '%s' is not approved", [region])
}
