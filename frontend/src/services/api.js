
import axios from 'axios';

const API_BASE_URL = 'https://manijewellers.onrender.com/api'; // Replace with your backend URL

// Fetch latest gold/silver rates from the backend
export const fetchRates = async () => {
  const response = await axios.get(`${API_BASE_URL}/rates/get`);
  return response.data; // Ensure it contains data with the rate fields
};

// Fetch the video URL from the backend (where user uploads video URL)
export const fetchVideo = async () => {
  const response = await axios.get(`${API_BASE_URL}/videos/get`);
  return response.data;
};
