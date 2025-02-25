#!/usr/local/bin/python3

import boto3
import mimetypes
import os
import requests
import sys

def download_file(url, file_path):
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()

        with open(file_path, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"File downloaded to {file_path}")
    
    except requests.exceptions.RequestException as e:
        print(f"Error downloading: {e}")



if len(sys.argv) != 4:
    print(f"Error: expected 3 arguments, but received {len(sys.argv) - 1}\n"
            "Hint: Run ./pythonscript.sh [FILE-URL] [BUCKET] [SECONDS]")
    sys.exit(1)

file_name = input("Enter file name for the downloaded file: ").strip()

image_url = sys.argv[1]

bucket_name = sys.argv[2]

public_link_secs = int(sys.argv[3])

path = os.path.join(os.getcwd(), file_name)

download_file(image_url, path)

s3 = boto3.client('s3', region_name="us-east-1")

content_type, encoding = mimetypes.guess_type(file_name)

if content_type is None:
    content_type = "application/octet-stream" 

try:
    with open(file_name, "rb") as file_data:
        s3.put_object(
            Body = file_data,
            Bucket = bucket_name,
            Key = file_name,
            ContentType = content_type
        )

    response = s3.generate_presigned_url(
                'get_object',
                Params = {'Bucket': bucket_name, 'Key': file_name },
                ExpiresIn = public_link_secs
                )

    print(f"File uploaded successfully. Public URL (expires in {public_link_secs} seconds):\n{response}")

except Exception as e:
    print(f"Error uploading to S3: {e}")
    sys.exit(1)




