from app import lambda_handler

if __name__ == "__main__":
    # Call the lambda handler function
    result = lambda_handler()
    print("Result:", result)