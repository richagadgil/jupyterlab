

IF "%NAME%"=="python" (
    py.test -v

) ELSE IF "%NAME%"=="integrity" (
    if !errorlevel! neq 0 exit /b !errorlevel!
    jlpm run build:core
    if !errorlevel! neq 0 exit /b !errorlevel!
    jlpm run integrity
    if !errorlevel! neq 0 exit /b !errorlevel!
    python -m jupyterlab.browser_check --core-mode
    if !errorlevel! neq 0 exit /b !errorlevel!
    python -m jupyterlab.browser_check --dev-mode
    if !errorlevel! neq 0 exit /b !errorlevel!
    jlpm run build
    if !errorlevel! neq 0 exit /b !errorlevel!
    jupyter lab build
    if !errorlevel! neq 0 exit /b !errorlevel!
    python -m jupyterlab.browser_check

) ELSE (
    jlpm run build:packages
    if !errorlevel! neq 0 exit /b !errorlevel!
    jlpm run build:test
    if !errorlevel! neq 0 exit /b !errorlevel!
    jlpm test
)

if !errorlevel! neq 0 exit /b !errorlevel!
