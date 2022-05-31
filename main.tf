resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "state" = {
                "enum" = [
                    "active",
                    "inactive",
                    "deleted"
                ],
                "type" = "string"
            },
            "userId" = {
                "type" = "string"
            },
            "version" = {
                "type" = "integer"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\n  \"state\": \"$${input.state}\",\n  \"version\": $${input.version}\n}"
        request_type         = "PUT"
        request_url_template = "/api/v2/users/$${input.userId}/state"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}