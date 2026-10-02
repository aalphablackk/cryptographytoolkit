#!/bin/bash
while :
do
echo ---------------------------------------------
echo 		CRYPTOGRAPHY TOOLKIT
echo ---------------------------------------------
echo "Quick tip: For every successful encryption/decryption, the encrypted or decrypted file becomes hidden"
echo 1.Symmetric Encryption
echo 2.Asymmetric Encryption
echo 3.Hash files
echo 4.Digital signature
echo 5.Generating Keys 
echo 6.Create a text file                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
echo 7.Show existing files
echo 8.View a file
echo 9.Rename file
echo 10.Show hidden files
echo 11.Delete a file
echo 12."exit"
echo "Choose an option: "
mkdir -p files
read choice
if [ "$choice" == "1" ]; then
        echo --- SYMMETRIC ENCRYPTION MENU ---
        echo 1. Encrypt File
        echo 2. Decrypt File
        echo 3. Back
        echo "Choose an option: "
        read choice
        if [ "$choice" == "1" ]; then
                echo "Kindly input the filename including the file extension"
                read filename
                openssl enc -aes-256-cbc -pbkdf2 -iter 1000 -in files/$filename -out files/enc$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File encrypted successfully"
        	        mv files/$filename files/.$filename
		fi
                echo "Press Enter to go back home"
                read
        elif [ "$choice" == "2" ]; then
                echo "Kindly input the filename including the file extension"
                read filename
                openssl enc -d -aes-256-cbc -pbkdf2 -iter 1000 -in files/$filename -out files/dec$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File Decrypted successfully"
        	        mv files/$filename files/.$filename
		fi
                echo "Press Enter to go back home"
                read
        else
                echo "Back to Menu"
        fi
elif [ "$choice" == "2" ]; then
        echo --- ASYMMETRIC ENCRYPTION MENU ---
        echo 1. Encrypt
        echo 2. Decrypt
        echo 3. Back
        echo "Choose an option: "
        read choice
        echo "Quick tip: Before you proceed, you need private key/Public Key. You can create them in the home menu if you don't already have them"
        if [ "$choice" == "1" ]; then
                echo --- Encrypting a file ---
                echo "Kindly input the filename including the file extension"
                read filename
                echo "Kindly input the public key filename"
                read publicfilename
                openssl pkeyutl -encrypt -inkey files/$publicfilename.pem -pubin -in files/$filename -out files/enc$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File encrypted successfully"
        	        mv files/$filename files/.$filename
		fi
                echo "Press Enter to go back home"
                read
        elif [ "$choice" == "2" ]; then
                echo --- Decrypting a file ---
                echo "Kindly input the filename including the file extension"
                read filename
                echo "Kindly input the private key filename"
                read privatefilename
                openssl pkeyutl -decrypt -inkey files/$privatefilename.pem -in files/$filename -out files/dec$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File decrypted successfully"
        	        mv files/$filename files/.$filename
		fi
                echo "Press Enter to go back home"
                read
	else
                echo "Back to Menu"
        fi
elif [ "$choice" == "3" ]; then
        echo --- FILE HASH MENU ---
        echo 1. SHA-256
        echo 2. SHA-512
        echo 3. Back
        echo "Choose an option: "
        read choice
        if [ "$choice" == "1" ]; then
                echo "Kindly input the filename including the file extension"
                read filename
                sha256sum files/$filename > files/sha256$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File hashed successfully"
		fi
                echo "Press Enter to go back home"
                read
        elif [ "$choice" == "2" ]; then
                echo "Kindly input the filename including the file extension"
                read filename
                sha512sum files/$filename > files/sha512$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File hashed successfully"
		fi
                echo "Press Enter to go back home"
                read
        else
                echo "Back to menu"
        fi

elif [ "$choice" == "4" ]; then
        echo --- DIGITAL SIGNATURE MENU ---
        echo 1. Sign a file
        echo 2. Verify a file
        echo 3. Back
        echo "Choose an option: "
        read choice
        echo "Quick tip: Before you proceed, you need private key/Public Key. You can create them in the home menu if you don't already have them"
        if [ "$choice" == "1" ]; then
                echo --- Signing a file ---
                echo "Kindly input the filename including the file extension"
                read filename
                echo "Kindly input the private key filename"
                read privatefilename
                openssl dgst -sha256 -sign files/$privatefilename.pem -out files/sig$filename files/$filename
	        if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File signed successfully"
		fi
                echo "Press Enter to go back home"
                read
        elif [ "$choice" == "2" ]; then
                echo --- Verifying a file ---
                echo "Kindly input the filename including the file extension" 
                read filename
                echo "Kindly input the signature filename including the file extension"
                read signature
                echo "Kindly input the public key filename"
                read publicfilename
                openssl dgst -sha256 -verify files/$publicfilename.pem -signature files/$signature files/$filename
                if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "File verified successfully"
		fi
       	        echo "Press Enter to go back home"
                read
	else
                echo "Back to Menu"
        fi
elif [ "$choice" == "5" ]; then
        echo --- GENERATING KEYS MENU ---
        echo 1. Private Key
        echo 2. Public Key
        echo 3. Back
        echo "Choose an option: "
        read choice
	echo "Quick tip: Make sure the filenames are similar to prevent mix-ups in case you will be creating multiple files"
        if [ "$choice" == "1" ]; then
                echo --- CREATING PRIVATE KEY ---
                echo "Kindly input the private key filename"
                read filename
                openssl genrsa -out files/$filename.pem 2048
	        if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
        	        echo "Private key file created successfully"
		fi               
                echo "Press Enter to go back home"
                read
        elif [ "$choice" == "2" ]; then
                echo --- CREATING PUBLIC KEY ---
                echo "Kindly input the private key filename you want to generate the public key from: "
                read privatefilename
                echo "Kindly input the public key filename"
                read publicfilename
                openssl rsa -in files/$privatefilename.pem -pubout -out files/$publicfilename.pem
		if [ $? -ne 0 ]; then
		    	echo "An error occurred"
		else
	                echo "Public key file created successfully"
		fi
                echo "Press Enter to go back home"
                read
        else
                echo "Back to Home"
        fi
elif [ "$choice" == "6" ]; then
        echo --- CREATE A TEXT FILE ---
        echo "Kindly input the filename"
        read filename
        nano files/$filename.txt
        if [ $? -ne 0 ]; then
	    	echo "An error occurred"
	else
        	echo "Your file has been saved successfully"
	fi 
        echo "Press Enter to go back home"
        read
elif [ "$choice" == "7" ]; then
        echo --- LIST OF EXISTING FILES ---
	dir ./files
	echo --- END OF EXISTING FILES ---
        echo "Press Enter to go back home"
        read
elif [ "$choice" == "10" ]; then
	echo --- LIST OF EXISTING FILES ---
	ls -la ./files
	echo --- END OF EXISTING FILES ---
        echo "Press Enter to go back home"
        read
elif [ "$choice" == "8" ]; then
        echo --- VIEW A FILE ---
        echo "Kindly input the filename including the file extension"
        read filename
        cat files/$filename
	echo "--- End of file ---"
        echo "Press Enter to go back home"
        read
elif [ "$choice" == "11" ]; then
        echo --- DELETE A FILE ---
        echo "Kindly input the filename including the file extension"
        read filename
        rm files/$filename
	if [ $? -ne 0 ]; then
	    	echo "An error occurred"
	else
        	echo "Your file has been deleted successfully"
	fi 
        echo "Press Enter to go back home"
        read
elif [ "$choice" == "9" ]; then
	echo --- FILE RENAME ---
	echo "Kindly input the old filename including the file extension"
        read oldfile
	echo "Kindly input the new filename including the file extension: "
        read newfile
	mv files/$oldfile files/$newfile
        if [ $? -ne 0 ]; then
	    	echo "An error occurred"
	else
		echo "You have successfully created file ($newfile)"
	fi

elif [ "$choice" == "12" ]; then
        echo --- THANKS FOR USING THE TOOLKIT ---
        echo =========== SEE YOU SOON ===========
        exit
else 
        echo  "Are you drunk? Enter a valid input"
        echo "Press Enter to go back home"
        read
fi
done
