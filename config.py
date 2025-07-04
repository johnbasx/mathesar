"""
Custom configuration for Mathesar in Coolify environment.
This file overrides database connection settings to ensure proper connectivity.
"""
import os

# Database connection settings
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_DB', 'mathesar'),
        'USER': os.environ.get('POSTGRES_USER', 'mathesar'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD', 'mathesar'),
        'HOST': os.environ.get('POSTGRES_HOST', 'db'),
        'PORT': os.environ.get('POSTGRES_PORT', '5432'),  # Using default PostgreSQL port
        'CONN_MAX_AGE': 600,
        'OPTIONS': {
            'connect_timeout': 30,  # Increased timeout
            'keepalives': 1,
            'keepalives_idle': 30,
            'keepalives_interval': 10,
            'keepalives_count': 5,
        },
    }
}

# Security settings
ALLOWED_HOSTS = ['*']
DEBUG = os.environ.get('DEBUG', 'false').lower() == 'true'

# Set this to True to use HTTP instead of HTTPS
USE_HTTP = True
