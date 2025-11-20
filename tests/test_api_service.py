import pytest
from unittest.mock import patch, Mock
from src.services import api_service
import pandas as pd


class TestApiService:
    """Test cases for API service module."""
    
    @patch('src.services.api_service.requests.get')
    def test_fetch_intraday_data_success(self, mock_get):
        """Test successful API data fetch."""
        # Mock successful response
        mock_response = Mock()
        mock_response.json.return_value = {
            "Meta Data": {
                "1. Information": "Intraday (5min) data",
                "2. Symbol": "IBM"
            },
            "Time Series (5min)": {
                "2023-01-01 16:00:00": {
                    "1. open": "100.0",
                    "2. high": "101.0",
                    "3. low": "99.0",
                    "4. close": "100.5",
                    "5. volume": "1000"
                }
            }
        }
        mock_response.raise_for_status.return_value = None
        mock_get.return_value = mock_response
        
        result = api_service.fetch_intraday_data("IBM", "5min")
        assert result is not None
        assert "Time Series (5min)" in result
    
    def test_parse_time_series(self):
        """Test time series parsing."""
        response = {
            "Time Series (5min)": {
                "2023-01-01 16:00:00": {
                    "1. open": "100.0",
                    "2. high": "101.0",
                    "3. low": "99.0",
                    "4. close": "100.5",
                    "5. volume": "1000"
                },
                "2023-01-01 15:55:00": {
                    "1. open": "99.5",
                    "2. high": "100.5",
                    "3. low": "99.0",
                    "4. close": "100.0",
                    "5. volume": "1200"
                }
            }
        }
        
        df = api_service.parse_time_series(response)
        assert not df.empty
        assert len(df) == 2
        assert list(df.columns) == ['open', 'high', 'low', 'close', 'volume']
