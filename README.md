These scripts provide a way to automatically commit changes made in TeXstudio to a Git repository.

## Usage

### Windows

- Put the `commit.bat` file in the root directory of your LaTeX document folder.
- In TeXstudio, navigate to `Options` -> `Configure TeXstudio` -> `Internal PDF Viewer`.
- Check "Auto-recompile document on changes". This will trigger the commit script whenever you compile your document.
- Go to `Build` -> `User Commands` and add these commands:
  - Name: `git-force:git-force` Command: `cmd /c "C:\path\to\latex\folder\commit.bat force"`
  - Name: `git-auto:git-auto` Command: `cmd /c "C:\path\to\latex\folder\commit.bat"`
    - Any name is fine, but I've had problems when using the default `user0` name.
- Add the following to:
  - `Build & View`: `... | txs:///git-force`
  - `Default Compiler`: `... | txs:///git-auto`

### MacOS/Linux

- Put the `commit.sh` file in the root directory of your LaTeX document folder.
- Make the script executable by running:
  ```bash
  chmod +x commit.sh
  ```
- In TeXstudio, navigate to `Options` -> `Configure TeXstudio` -> `Internal PDF Viewer`.
- Check "Auto-recompile document on changes". This will trigger the commit script whenever you compile your document.
- Go to `Build` -> `User Commands` and add these commands:
  - Name: `git-force:git-force` Command: `/path/to/latex/folder/commit.sh force`
  - Name: `git-auto:git-auto` Command: `/path/to/latex/folder/commit.sh`
- Add the following to:
  - `Build & View`: `... | txs:///git-force`
  - `Default Compiler`: `... | txs:///git-auto`

Note: either of the commands can be ommitted if the feature is not needed. For the command names, any name is fine, but I've had problems when using the default `user0` name. After adding the commands, check the Log window in TeXstudio to ensure that the commands are being executed correctly. If you get an error, make sure the path to `commit.bat` is correct, and the names of the commands match what you set in the User Commands.
