return {
  {
    "idossha/matlab.nvim",
    ft = "matlab",
    config = function()
      require("matlab").setup({
        auto_start = false,
        environment = {
          LD_LIBRARY_PATH = "/usr/local/lib",
          -- for figures, need to check 'echo $DISPLAY'
          DISPLAY = ":1",
        },
      })
    end,
    keys = {
      {
        "<leader>ms",
        function()
          vim.cmd("MatlabStartServer")
        end,
        mode = "n",
        desc = "MATLAB: Start server",
      },
      {
        "<leader>mq",
        function()
          vim.cmd("MatlabStopServer")
        end,
        mode = "n",
        desc = "MATLAB: Stop server",
      },
      {
        -- Сворачивает или разворачивает все MATLAB cell sections, помеченные через %%.
        "<leader>mF",
        function()
          vim.cmd("MatlabToggleAllCellFolds")
        end,
        mode = "n",
        desc = "MATLAB: Toggle all cell folds",
      },
    },
  },
}
