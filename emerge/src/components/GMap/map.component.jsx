import React from 'react';
import { Map, GoogleApiWrapper, Marker } from 'google-maps-react';
import './map.styles.scss'

const mapStyles = {
  width: '100%',
  height: '100%',
};

// global variables that hold the longitude and latitude
var latitude = null;
var long = null;

// this creates a map with a marker on it.
export class GMap extends React.Component {

  render(){
    
    // parsing the longitude and latitude from location field
    // into 2 separate variables long and latitude
    // if they are the same then do nothing if they are not change them 
    if(latitude !== this.props.location.substr(0,this.props.location.indexOf(',')).substr(5))
    {
    latitude = this.props.location.substr(0,this.props.location.indexOf(',')).substr(5);
    }
    if(long !== this.props.location.substr(this.props.location.indexOf(',')).substr(8))
    {
    long = this.props.location.substr(this.props.location.indexOf(',')).substr(8);
    }
  return (
      <div className='mapStyles'>
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
  apiKey: 'AIzaSyCVYm77ZYuWWdbcQ2zrbEv_yg1DH_MyvJY'
})(GMap);