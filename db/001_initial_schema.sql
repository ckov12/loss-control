-- PostgreSQL database schema for the Loss Control Platform

-- Table for Projects
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Inspections
CREATE TABLE inspections (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    inspection_date DATE NOT NULL,
    inspector_name VARCHAR(255),
    findings TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Recommendations
CREATE TABLE recommendations (
    id SERIAL PRIMARY KEY,
    inspection_id INT REFERENCES inspections(id),
    recommendation_text TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Security Management
CREATE TABLE security_management (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    security_plan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Alerts
CREATE TABLE alerts (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    alert_message TEXT NOT NULL,
    alert_level VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Audit Logs
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Documents
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    document_name VARCHAR(255) NOT NULL,
    document_url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Dashboard Views
CREATE TABLE dashboard_views (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    view_name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_projects_name ON projects(name);
CREATE INDEX idx_inspections_project_id ON inspections(project_id);
CREATE INDEX idx_recommendations_inspection_id ON recommendations(inspection_id);
CREATE INDEX idx_security_management_project_id ON security_management(project_id);
CREATE INDEX idx_alerts_project_id ON alerts(project_id);
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_documents_project_id ON documents(project_id);
CREATE INDEX idx_dashboard_views_project_id ON dashboard_views(project_id);