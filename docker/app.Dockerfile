FROM python:3.9-slim
RUN echo 'print("Hello from Docker! This is my Linux Lab!")' > app.py
CMD ["python", "app.py"]
