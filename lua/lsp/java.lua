local home = os.getenv('HOME')
local java17 = os.getenv('JAVA_HOME_17')
local jdtls = require('jdtls')
local root_markers = {'gradlew', 'mvnw', '.git', 'pom.xml'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local remap = require("me.util").remap

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  --jdtls.setup.add_commands()

  -- Default keymaps
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  require("lsp.defaults").on_attach(client, bufnr)

  -- Java extensions
  remap("n", "<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  remap("n", "<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
  remap("n", "<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
  remap("n", "<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  remap("n", "<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  remap("v", "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, "Extract method")
  remap("n", "<C-U>", jdtls.update_project_config, bufopts, "Update project config")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local bundles = {
  vim.fn.glob(home .. '/.share/bin/java-debug/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '.share/bin/vscode-java-test/*.jar'), "\n"))

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    bundles = bundles
  },
  root_dir = root_dir,
  settings = {
    java = {
      format = {
        -- Grab formatter rule from https://github.com/google/styleguide
        -- and save it here!
        settings = {
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = home .. "/.sdkman/candidates/java/17.0.8-amzn",
          },
        }
      }
    }
  },
  cmd = {
    java17 .. "/bin/java",
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx2g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',
    '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.26.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', '/opt/homebrew/Cellar/jdtls/1.26.0/libexec/config_mac',
    '-data', workspace_folder,
  },
}

local M = {}
function M.make_jdtls_config()
  return config
end
return M

