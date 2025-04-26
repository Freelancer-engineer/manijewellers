import React, { useEffect, useState } from 'react';
import VideoPlayer from './components/VideoPlayer';
import RateBox from './components/RateBox';
import { fetchRates, fetchVideo } from './services/api';
import './App.css';
import logo from './assets/logo.png';
const App = () => {
  const [rates, setRates] = useState(null); // Will store the rate data here
  const [videoUrl, setVideoUrl] = useState("https://www.youtube.com/watch?v=-zCv4Y_pEcs"); // Default video URL
  const [loading, setLoading] = useState(true); // To track if data is still loading

  // Fetch Gold/Silver rates and video URL
  useEffect(() => {
    const getRates = async () => {
      try {
        const response = await fetchRates();
        if (response?.rate) {
          setRates(response.rate); // Set rates properly from the response
          setLoading(false); // Data fetched, so we stop loading
        }
      } catch (error) {
        console.error('Error fetching rates:', error);
        setLoading(false); // Stop loading in case of error as well
      }
    };

    const getVideo = async () => {
      try {
        const videoData = await fetchVideo();
        if (videoData?.videoUrl) {
          setVideoUrl(videoData.videoUrl); // Set video URL from the backend
        }
      } catch (error) {
        console.error('Error fetching video:', error);
      }
    };

    getRates(); // Fetch rates initially
    getVideo(); // Fetch video URL initially

    // Poll for updated rates every 5 seconds (rapid updates)
    const intervalId = setInterval(() => {
      getRates(); // Fetch new rates rapidly
    }, 5000); // You can adjust this interval as per your needs

    return () => clearInterval(intervalId); // Cleanup interval on unmount
  }, []);

  const currentDate = new Date().toLocaleDateString();

  return (
    <div className="App">
      {/* Video Player */}
      <div className="video-container">
        <VideoPlayer videoUrl={videoUrl} />
      </div>

      <div className="logo-container">
        <img src={logo} alt="Logo" className="logo-image" />
      </div>
      

      {/* Rates Row */}
      <div className="rates-row">
        {loading ? (
          <p>Loading rates...</p> // Show loading text while rates are being fetched
        ) : rates ? (
          <>
            <RateBox title="Gold 24K" rate={rates.gold24k} />
            <RateBox title="Gold 22K" rate={rates.gold22k} />
            <RateBox title="Gold 20K" rate={rates.gold20k} />
            <RateBox title="Gold 18K" rate={rates.gold18k} />
            <RateBox title="Silver" rate={rates.silver} />
          </>
        ) : (
          <p>No rates available</p> // If no data is available
        )}
      </div>

      {/* Date fetched from the backend */}
      {rates && (
        <div className="date">
          <p>{rates.date}</p> {/* Display date fetched from the backend */}
        </div>
      )}

      {/* Tagline */}
      <div className="tagline">
        <p>Rates are valid from 11:00 AM to 11:00 PM</p>
      </div>
    </div>
  );
};

export default App;
