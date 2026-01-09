FROM python:3.11.11-slim-bookworm

# Set working directory
WORKDIR /app

#Copy only requirements first for better caching
COPY requirements.txt ./

#Install dependencies
RUN pip install -r requirements.txt

#Copy the application code
COPY app ./

# Expose Streamlit port
EXPOSE 8501

# Streamlit entrypoint
CMD ["streamlit", "run", "./data_process_db.py"]
