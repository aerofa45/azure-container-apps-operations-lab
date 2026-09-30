from fastapi import FastAPI

app = FastAPI(title="Azure Container Apps Operations Lab", version="1.0.0", description="Minimal service used to demonstrate container deployment and cloud operations on Azure.")

@app.get("/")
def root():
    return {"service": "azure-container-apps-operations-lab", "message": "Service is running."}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/ready")
def ready():
    return {"status": "ready"}
