local Y = {}
Y.on_new_config = function(new_config)
  new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
end

Y.settings = {
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        enable = false,
        url = '',
      },
      -- schemas = require('schemastore').yaml.schemas(),
    },
  },
}
return Y
