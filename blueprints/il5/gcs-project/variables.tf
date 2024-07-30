/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Project ID"
  type        = string
  # TODO: Update the Project ID , example project-abc-123
}

variable "keyring" {
  description = "Keyring attributes."
  type = object({
    location = string
    name     = string
  })
  default = {
    location = "us-east4"
    name     = "gcs-keyring"

    # Example location = "us-east4"
    # Example name     = "april"
    # TODO: Update the name of the Key Ring, and location. The Location for IL5 can be us-east4 or us-central1
  }
}

# variable "uniform_bucket_level_access" {
#   description = "Enable or disable uniform bucket level access"
#   type        = bool
#   default     = true
#   validation {
#     condition     = contains([true, false], var.uniform_bucket_level_access)
#     error_message = "uniform_bucket_level_access must be either true or false."
#   }
# }

# variable "public_access_prevention" {
#   description = "Enable or disable public access prevention"
#   type        = bool
#   default     = true
#   validation {
#     condition     = contains([true, false], var.public_access_prevention)
#     error_message = "public_access_prevention must be either true or false."
#   }
# }

variable "uniform_bucket_level_access" {
  description = "Enable or disable uniform bucket level access"
  type        = bool
  default     = true
  validation {
    condition     = var.uniform_bucket_level_access == true || var.uniform_bucket_level_access == false
    error_message = "uniform_bucket_level_access must be either true or false."
  }
}

variable "public_access_prevention" {
  description = "Enable or disable public access prevention"
  type        = string
  default     = "inherited"
  validation {
    condition     = contains(["enforced", "inherited"], var.public_access_prevention)
    error_message = "public_access_prevention must be either 'enforced' or 'inherited'."
  }
}

variable "prefix" {
  description = "Optional prefix used to generate the bucket name."
  type        = string
  default     = "string"
  # TODO: Update the name of the prefix, for example "dino"
  validation {
    condition     = var.prefix != ""
    error_message = "Prefix cannot be empty, please use null instead."
  }
}

variable "name" {
  description = "Bucket name suffix."
  type        = string
  # TODO: Update the name of the bucket suffix For example welcome-data
}

variable "location" {
  description = "Bucket location."
  type        = string
  default     = "us-east4"
  # TODO: Update the Bucket Location. The Location for IL5 can be us-east4 or us-cental1
}

variable "email" {
  # Example default = "admin.user-anme@example.google.com"
  description = "Email address of the user."
  type        = string
  # TODO: Update the email address
}

variable "autoclass" {
  description = "Enable autoclass to automatically transition objects to appropriate storage classes based on their access pattern. If set to true, storage_class must be set to STANDARD. When set to true, All objects added to the bucket begin in Standard storage, even if a different storage class is specified in the request."
  type        = bool
  default     = true
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Storage class must be one of STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "keys" {
  description = "Key names and base attributes. Set attributes to null if not needed."
  type = map(object({
    destroy_scheduled_duration    = optional(string)
    rotation_period               = optional(string)
    labels                        = optional(map(string))
    purpose                       = optional(string, "ENCRYPT_DECRYPT")
    skip_initial_version_creation = optional(bool, false)
    version_template = optional(object({
      algorithm        = string
      protection_level = optional(string, "HSM")
    }))

    iam = optional(map(list(string)), {})
    iam_bindings = optional(map(object({
      members = list(string)
      role    = string
      condition = optional(object({
        expression  = string
        title       = string
        description = optional(string)
      }))
    })), {})
    iam_bindings_additive = optional(map(object({
      member = string
      role   = string
      condition = optional(object({
        expression  = string
        title       = string
        description = optional(string)
      }))
    })), {})
  }))
  default = {
    "default" = {
      destroy_scheduled_duration    = null
      rotation_period               = null
      labels                        = null
      purpose                       = "ENCRYPT_DECRYPT"
      skip_initial_version_creation = false
      version_template = {
        algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "HSM"
      }

      iam                   = {}
      iam_bindings          = {}
      iam_bindings_additive = {}
    }
  }
  nullable = false
}