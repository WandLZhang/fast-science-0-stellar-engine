module "resman-kms" {
  source     = "../../../modules/kms"
  project_id = var.automation.project_id
  keyring = {
    name     = "resman"
    location = var.locations.kms
  }
  keys = {
    resman = {
      purpose         = "ENCRYPT_DECRYPT"
      rotation_period = "7776000s"
      version_template = {
        algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "HSM"
      }
    }
  }
  iam = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
      "serviceAccount:service-${var.automation.project_number}@gs-project-accounts.iam.gserviceaccount.com"
    ]
  }
}

module "tenant-project-keys" {
  source     = "../../../modules/kms"
  project_id = module.tenant-self-iac-projects[each.key].project_id
  for_each   = local.tenant_envs
  iam = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
      module.tenant-core-sa[each.key].iam_email,
      "serviceAccount:service-${var.automation.project_number}@gs-project-accounts.iam.gserviceaccount.com"
    ]
  }
  keyring = {
    name     = "${each.key}-keyring"
    location = try(each.value.locations.kms != "", false) ? each.value.locations.kms : var.locations.kms
  }
  keys = {
    gcs = {
      purpose         = "ENCRYPT_DECRYPT"
      labels          = { service = "gcs" }
      locations       = try(each.value.locations.kms != "", false) ? each.value.locations.kms : var.locations.kms
      rotation_period = "7776000s"
      version_template = {
        algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "HSM"
      }
    }
  }
}

## TODO: Get this to work
## projects/se-il5-prod-iac-core-0/locations/us-east4/keyRings/gcs/cryptoKeys/gcs/cryptoKeyVersions/1
# resource "google_kms_crypto_key_iam_member" "crypto_key" {
#   for_each      = local.tenant_envs
#   crypto_key_id = "${var.automation.project_id}/${var.locations.gcs}/gcs/gcs"
#   role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
# #   member        = "serviceAccount:${module.tenant-core-sa[each.key].iam_email}"
#   member = 
#     # member = "serviceAccount:service-${var.automation.project_number}@gs-project-accounts.iam.gserviceaccount.com"
# # }
# projects/se-il5-prod-iac-core-0/locations/us-east4/keyRings/gcs/cryptoKeys/gcs/cryptoKeyVersions/1
