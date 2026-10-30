# CSCI461 Introduction to Big Data — Assignment #1
## Dockerized Data, Text Analysis and Machine Learning

**Nile University | School of Information Technology and Computer Science | Fall 2026**  
**Total Marks:** 20 Marks + 2 Bonus Marks | **Repository:** `bd-a1`

---

## 👥 Team Members & Task Assignment Matrix

| Member | Role | Core Assignment Responsibilities | Primary Deliverables | Discussion Prep Focus |
| :--- | :--- | :--- | :--- | :--- |
| **Member 1** | **Docker & DevOps Lead** | Docker environment setup, Dockerfile creation, image building, container port mapping, bind mounts, Docker Hub distribution, lifecycle evidence. | `Dockerfile`, Docker commands in `README.md`, screenshots of container lifecycle, Docker Hub image publication. | Dockerfile layers, image vs container, bind mount vs volume, port mapping `HOST:CONTAINER`, Docker Hub registry. |
| **Member 2** | **Data Cleaning & Preprocessing Specialist** | Dataset loading, metadata reporting, missing value and duplicate remediation, `loc` and `iloc` (`np.r_`), transformations, sampling methods. | Section 4 in `analysis.ipynb`, `data/dataset.csv`, export of `output/cleaned_data.csv`. | Decision justification for missing values/duplicates, `loc` vs `iloc`, sampling biases, stratified vs cluster sampling. |
| **Member 3** | **Text Analysis & Feature Engineering Specialist** | Text feature engineering (char/word/unique counts, avg length), correlation matrix & heatmap, text cleaning pipeline (`cleaned_text`), tokenization, word frequency analysis, spam vs ham group comparisons, 5 written insights. | Section 5 in `analysis.ipynb`, `output/figures/correlation_heatmap.png`, `output/figures/word_frequency.png`, `output/figures/group_comparison.png`. | Regex cleaning decisions, stop-word removal impact, tokenization, correlation vs causation, observation-evidence-interpretation logic. |
| **Member 4** | **Machine Learning & Modeling Specialist** | TF-IDF feature extraction, stratified train/test split, Multinomial Naive Bayes classifier, Bonus model comparison (Logistic Regression), K-Means clustering ($k$ selection & silhouette score), cluster top terms & comparison with labels. | Section 6 & 10 in `analysis.ipynb`, `output/figures/confusion_matrix.png`, `output/model_metrics.txt`, `output/cluster_summary.txt`. | TF-IDF formulation, evaluation metrics (precision/recall/F1 trade-offs), Naive Bayes assumptions, why K-Means is unsupervised, interpreting silhouette scores. |

---

## 📁 Repository Structure

```text
bd-a1/
├── Dockerfile                  # Specification for custom Jupyter environment
├── requirements.txt            # Python dependencies (scikit-learn, seaborn, nltk, etc.)
├── README.md                   # Comprehensive documentation and reproduction guide
├── .gitignore                  # Git ignore rules for checkpoints and temporary files
├── data/
│   ├── README.md               # Dataset documentation and UCI download instructions
│   └── dataset.csv             # Raw input dataset (SMS Spam Collection)
├── notebook/
│   └── analysis.ipynb          # End-to-end runnable Jupyter Notebook
├── output/
│   ├── cleaned_data.csv        # Preprocessed and cleaned dataset
│   ├── model_metrics.txt       # Supervised classification metrics & confusion matrix
│   ├── cluster_summary.txt     # K-Means clustering quality, sizes & top terms
│   └── figures/
│       ├── correlation_heatmap.png
│       ├── word_frequency.png
│       ├── group_comparison.png
│       └── confusion_matrix.png
└── screenshots/
    ├── README.md               # Guide for required container evidence screenshots
    ├── docker_build.png        # Evidence of successful image build
    ├── docker_images.png       # Evidence of custom image on host
    ├── docker_ps.png           # Evidence of running container with port mapping
    ├── docker_ps_a.png         # Evidence of container listing
    ├── docker_logs.png         # Container output logs with Jupyter access URL
    └── docker_inspect.png      # Container inspection showing bind mount
```

---

## 🐳 Docker Architecture & Concepts Explained

### 1. Docker Image vs. Container (Section 3.2)
- **Docker Image:** An immutable, read-only template built from layered instructions in a `Dockerfile`. It encapsulates the OS environment, libraries, system binaries, code, and dependencies needed to run an application. Images are stored locally or in registries like Docker Hub.
- **Docker Container:** A runnable, isolated instance of an image. When you execute `docker run`, Docker creates a thin, read-write layer on top of the underlying image layers. Multiple independent containers can run concurrently from the exact same image without interfering with one another.

### 2. Port Mapping: `HOST_PORT:CONTAINER_PORT` for `-p 8888:8888` (Section 3.2)
- Containers run in their own isolated network namespace by default and cannot be reached directly from host browser interfaces.
- The syntax `-p HOST_PORT:CONTAINER_PORT` binds port `8888` on the physical host machine to port `8888` inside the container:
  - **`CONTAINER_PORT` (8888):** The internal port where JupyterLab listens inside the container.
  - **`HOST_PORT` (8888):** The port opened on your local machine.
- When you navigate to `http://localhost:8888` on your host browser, the Docker daemon forwards network traffic into the container's Jupyter server.

### 3. Persistent Output with a Bind Mount (Section 3.3)
- Containers are ephemeral: any file created inside a container is lost when the container is deleted (`docker rm`).
- By mounting the host folder with `-v "${PWD}/output:/home/jovyan/work/output"`, changes written to `/home/jovyan/work/output` inside the notebook are immediately saved on the host filesystem under `bd-a1/output/`.
- Even if the container is stopped or removed, all generated figures (`.png`), metrics (`.txt`), and cleaned data (`.csv`) remain safely persisted on the host.

---

## 🚀 Step-by-Step Reproduction Guide

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.
- [Git](https://git-scm.com/) installed.

### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/bd-a1.git
cd bd-a1
```

### 2. Build the Custom Docker Image (Section 3.1)
```bash
docker build -t bd-a1:latest .
```
*Note: This pulls `quay.io/jupyter/scipy-notebook:latest`, installs `requirements.txt`, copies project starter files, and sets up working permissions.*

### 3. Run the Container with Port Mapping and Bind Mount (Sections 3.2 & 3.3)

**On Windows (PowerShell):**
```powershell
docker run -it --rm -p 8888:8888 -v "${PWD}/output:/home/jovyan/work/output" --name bd-a1-container bd-a1:latest
```

**On Linux / macOS:**
```bash
docker run -it --rm -p 8888:8888 -v "$(pwd)/output:/home/jovyan/work/output" --name bd-a1-container bd-a1:latest
```

### 4. Execute the Notebook inside JupyterLab
1. Locate the access URL with authentication token printed in your terminal (e.g., `http://127.0.0.1:8888/lab?token=...`).
2. Open the URL in your web browser.
3. Open `notebook/analysis.ipynb`.
4. Run the entire pipeline via **Kernel ➔ Restart Kernel and Run All Cells...**
5. Verify that all four figures, cleaned dataset, model metrics, and cluster summaries are written to the `output/` directory.

---

## 🔍 Container Lifecycle Evidence (Section 3.4)

Run the following commands in a separate terminal while the container is executing, and save the screenshots into `screenshots/`:

```bash
# 1. List available local images
docker images

# 2. List running containers (verifies port mapping and container status)
docker ps

# 3. List all containers (including exited containers)
docker ps -a

# 4. View container logs
docker logs bd-a1-container

# 5. Inspect container configuration (verify bind mounts under Mounts section)
docker inspect bd-a1-container
```

---

## ☁️ Docker Hub Distribution (Section 3.5)

### Member 1: Tag and Push Image to Docker Hub
```bash
# Log in to Docker Hub
docker login

# Tag the local image with your Docker Hub username
docker tag bd-a1:latest <your-dockerhub-username>/bd-a1:latest

# Push to Docker Hub
docker push <your-dockerhub-username>/bd-a1:latest
```

**Published Image Repository:**
- **Repository:** `docker.io/<your-dockerhub-username>/bd-a1`
- **Tag:** `latest`

### Peer Verification (Another Team Member)
Another team member must pull and run the published image to confirm zero-configuration reproducibility:
```bash
docker pull <your-dockerhub-username>/bd-a1:latest
docker run -it --rm -p 8888:8888 -v "${PWD}/output:/home/jovyan/work/output" <your-dockerhub-username>/bd-a1:latest
```

---

## 🌟 Bonus Marks Implementation (Section 10)

1. **GitHub Repository (+0.5 Mark):**  
   Published clean repository structure, strict `.gitignore`, modular layout, and exhaustive reproduction guide.
2. **Model Extension & Comparison (+0.5 Mark):**  
   - Implemented and benchmarked **Multinomial Naive Bayes** against **Logistic Regression** on TF-IDF word & bi-gram representations.
   - Comparative evaluation metrics (Accuracy, Precision, Recall, F1) exported automatically to `output/model_metrics.txt`.

---

