variable "appmesh_virtual_routers" {
  description = <<EOT
Map of appmesh_virtual_routers, attributes below
Required:
    - mesh_name
    - name
    - spec (block):
        - listener (optional, block):
            - port_mapping (required, block):
                - port (required)
                - protocol (required)
Optional:
    - mesh_owner
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    mesh_name  = string
    name       = string
    mesh_owner = optional(string)
    region     = optional(string)
    tags       = optional(map(string))
    tags_all   = optional(map(string))
    spec = object({
      listener = optional(list(object({
        port_mapping = object({
          port     = number
          protocol = string
        })
      })))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_routers : (
        length(v.mesh_name) >= 1 && length(v.mesh_name) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

