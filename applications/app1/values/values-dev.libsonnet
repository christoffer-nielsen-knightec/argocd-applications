local env = std.extVar('env');
local values = if env == 'dev' then import '../../../values/values-dev.libsonnet'
              else if env == 'qa' then import '../../../values/values-qa.libsonnet'
              else if env == 'stage' then import '../../../values/values-stage.libsonnet'
              else if env == 'prod' then import '../../../values/values-prod.libsonnet'
              else error 'Unsupported environment: ' + env;

local patch = {
    APPLICATION_NAME: "overwritten-app1",
};

/* Used to merge two or more objects, allowing you to selectively override
 specific fields in the base object with values from the patch object */
std.mergePatch(values, patch)