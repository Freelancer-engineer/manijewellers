import React from 'react';

const RateBox = ({ title, rate }) => {
  return (
    <div className="rate-box">
      <h2>{title}</h2>
      <p>₹ {rate && rate !== 0 ? rate : 'N/A'}</p> {/* If rate is 0 or null, show 'N/A' */}
    </div>
  );
};

export default RateBox;
