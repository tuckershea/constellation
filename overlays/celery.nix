final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (py-final: py-prev: {
      celery = py-prev.celery.overridePythonAttrs (oldAttrs: {
        disabledTests = (oldAttrs.disabledTests or []) ++ [
          "test_regression_worker_startup_info"
          "test_check_privileges"
        ];
      });
    })
  ];
}
