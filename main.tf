resource "aws_appmesh_virtual_router" "appmesh_virtual_routers" {
  for_each = var.appmesh_virtual_routers

  mesh_name  = each.value.mesh_name
  name       = each.value.name
  mesh_owner = each.value.mesh_owner
  region     = each.value.region
  tags       = each.value.tags
  tags_all   = each.value.tags_all

  spec {
    dynamic "listener" {
      for_each = each.value.spec.listener != null ? each.value.spec.listener : []
      content {
        port_mapping {
          port     = listener.value.port_mapping.port
          protocol = listener.value.port_mapping.protocol
        }
      }
    }
  }
}

