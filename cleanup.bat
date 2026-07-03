@echo off
REM ========================================================================
REM  cleanup.bat - Windows equivalent of cleanup.sh
REM  Cleans up temporary files, uploads, caches, and node_modules.
REM ========================================================================

echo.🧹 Memulai proses pembersihan file sementara (cleanup)...

REM Memastikan direktori uploads dan outputs ada
if not exist uploads mkdir uploads
if not exist outputs mkdir outputs

REM 1. Membersihkan folder uploads
echo.🗑️  Menghapus semua file video mentah di dalam uploads/...
del /q /s uploads\* >nul 2>&1

REM 2. Membersihkan file sementara di dalam folder outputs/
echo.🗑️  Menghapus video sumber (raw) dan file audio sementara di dalam outputs/...
del /q /s outputs\video_asli.mp4 >nul 2>&1
del /q /s outputs\*_audio.wav >nul 2>&1
del /q /s outputs\*.json3 >nul 2>&1

REM 3. Membersihkan Cache Python
echo.🗑️  Menghapus file cache Python (__pycache__)...
for /d /r . %%d in (__pycache__) do @if exist "%%d" rmdir /s /q "%%d" 2>nul
for /d /r . %%d in (.pytest_cache) do @if exist "%%d" rmdir /s /q "%%d" 2>nul
for /d /r . %%d in (.ruff_cache) do @if exist "%%d" rmdir /s /q "%%d" 2>nul

REM 4. Membersihkan node_modules frontend
echo.🗑️  Menghapus node_modules frontend...
if exist web\dashboard\node_modules rmdir /s /q web\dashboard\node_modules
if exist web\dashboard\dist rmdir /s /q web\dashboard\dist

REM 5. Membersihkan .cache & .local (WARNING)
REM Hati-hati: Folder .cache menyimpan model AI (HuggingFace/Whisper) berukuran Gigabytes!
REM Jika dihapus, pipeline akan mendownload ulang model AI dari awal. Buka komentar di bawah JIKA Anda benar-benar ingin menghapusnya.
REM echo.🗑️  Menghapus .cache dan .local...
REM if exist .cache rmdir /s /q .cache
REM if exist .local rmdir /s /q .local

echo.✅ Pembersihan selesai! Ruang penyimpanan telah dibebaskan.