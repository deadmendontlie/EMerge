import React from 'react';
import { Map, GoogleApiWrapper, Marker } from 'google-maps-react';
import './map.styles.scss'

const mapStyles = {
  width: '100%',
  height: '100%',
};

export class GMap extends React.Component {

  render(){
    // parsing the longitude and latitude from location field
    // into 2 separate variables long and latitude
    const latitude = this.props.location.substr(0,this.props.location.indexOf(',')).substr(5);
    const long = this.props.location.substr(this.props.location.indexOf(',')).substr(8);
  return (
      <div className='mapStyles'>
        {/* {console.log("location" + this.props.location)}
        {console.log("lat" + latitude)}
        {console.log("long"+ long)} */}
        {/* Creating the Map and a Marker with the specified latitude and longitude */}
        <Map className='mapStyles'
          google={this.props.google}
          zoom={8}
          style={mapStyles}
          initialCenter={{ lat: latitude, lng: long}}
        >
        <Marker position={{ lat: latitude, lng: long}} />
        </Map>
    </div>
  );
  }
}
// this is my google API key from GCP 
// gives us access to the Map
export default GoogleApiWrapper({
  apiKey:
})(GMap);
