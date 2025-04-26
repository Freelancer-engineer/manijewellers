import React from 'react';

const VideoPlayer = ({ videoUrl }) => {
  const extractYouTubeID = (url) => {
    const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/;
    const match = url.match(regExp);
    return (match && match[2].length === 11) ? match[2] : null;
  };

  const isYouTubeVideo = videoUrl.includes('youtube.com') || videoUrl.includes('youtu.be');

  return (
    <div className="video-player">
      {isYouTubeVideo ? (
        <iframe
          width="100%"
          height="500px"
          src={`https://www.youtube.com/embed/${extractYouTubeID(videoUrl)}?autoplay=1&loop=1&playlist=${extractYouTubeID(videoUrl)}`}
          title="YouTube video player"
          frameBorder="0"
          allow="autoplay; fullscreen"
          allowFullScreen
        />
      ) : (
        <video width="100%" height="500px" controls loop autoPlay>
          <source src={videoUrl} type="video/mp4" />
          Your browser does not support the video tag.
        </video>
      )}
    </div>
  );
};

export default VideoPlayer;
