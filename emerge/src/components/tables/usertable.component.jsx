import React from 'react';
import { Panel } from "@bumaga/tabs";
import axios from 'axios';
import GMap from '../GMap/map.component';
import CustomButton from '../custom-button/custom-button.component';
import Popup from "reactjs-popup";
import './usertable.styles.scss';

//Gives the buttons functionality to change reports' statuses
function handleClick(passed_report_id, passed_status) {
    axios.put('http://18.212.156.43/update_status', {
        report_id: passed_report_id,
        status: passed_status
    })
    .then((reponse) => {
        console.log(reponse);
    }, (error) => {
        console.log(error);
    })
}

//Creates the rows of reports on the main homepage for regular users
class UserTable extends React.Component {  
    state = {
        reports: [],
        municipality_id: null,
    }

    //Gets all of the reports for the user's corresponding municipality
    componentDidMount() {
        axios.post('http://18.212.156.43/get_muni_reports', {
            municipality_id: this.props.municipality_id
        })
        .then((response) => {
            console.log(response.data);
            const reports = response.data;
            this.setState({ reports });
        }, (error) => {
            console.log(error);
        })
    }
        // Whenever data is being update in the db, we are pulling
    // the newest information with component did update
    componentDidUpdate() {
        if(this.props.municipality_id !== this.state.municipality_id)
        {
        axios.post('http://18.212.156.43/get_muni_reports', {
            municipality_id: this.props.municipality_id
        })
        .then((response) => {
            console.log(response.data);
            const reports = response.data;
            this.setState({ reports });
        }, (error) => {
            console.log(error);
        })
    }
    }
    

    //Creates the user's three tabs using the municipalities corresponding reports
    render() {

        const incoming = this.state.reports.filter(item => item.status === "New").map(function(item){
            return <div className="container row">
                        <div className="information-container">
                            <p hidden>report_id={item.report_id}</p>
                            <p><b>Name:</b> {item.name}</p>
                            <p><b>Phone:</b> {item.phone}</p>
                            <p><b>Description:</b> {item.message}</p>
                            <p><b>Time Submitted:</b> {item.timestamp}</p>
                            {/* Createad a popup window and imbeded google maps into it */}
                            <Popup modal trigger={<CustomButton>Location: {item.GPS}</CustomButton>}>
                                <div className="size">
                                    <GMap location={item.GPS}></GMap>
                                </div>
                            </Popup>
                        </div>
                        <div className="button-container">
                            <button className="acknowledge-button" 
                            onClick={() => {handleClick(item.report_id, "Dispatched");
                            
                        }}>Acknowledge</button>
                        </div>
                    </div>;
        });

        const acknowledged = this.state.reports.filter(item => item.status === "Dispatched").map(function(item){
            return <div className="container row">
                        <div className="information-container">
                            <p hidden>report_id={item.report_id}</p>
                            <p><b>Name:</b> {item.name}</p>
                            <p><b>Phone:</b> {item.phone}</p>
                            <p><b>Description:</b> {item.message}</p>
                            <p><b>Time Submitted:</b> {item.timestamp}</p>
                            {/* Createad a popup window and imbeded google maps into it */}
                            <Popup modal trigger={<CustomButton>Location: {item.GPS}</CustomButton>}>
                                <div className="size">
                                    <GMap location={item.GPS}></GMap>
                                </div>
                            </Popup>
                        </div>
                        <div className="button-container">
                            <button className="solve-button" onClick={() => {handleClick(item.report_id, "Closed")}}>Solve</button>
                        </div>
                    </div>;
        });

        const solved = this.state.reports.filter(item => item.status === "Closed").map(function(item){
            return <div className="container row">
                        <div className="information-container">
                            <p hidden>report_id={item.report_id}</p>
                            <p><b>Name:</b> {item.name}</p>
                            <p><b>Phone:</b> {item.phone}</p>
                            <p><b>Description:</b> {item.message}</p>
                            <p><b>Time Submitted:</b> {item.timestamp}</p>
                            {/* Createad a popup window and imbeded google maps into it */}
                            <Popup modal trigger={<CustomButton>Location: {item.GPS}</CustomButton>}>
                                <div className="size">
                                    <GMap location={item.GPS}></GMap>
                                </div>
                            </Popup>
                        </div>
                    </div>;
        });

        return (
            [<Panel>
                {incoming}   
            </Panel>,
            <Panel>
                {acknowledged}
            </Panel>,
            <Panel>
                {solved}
            </Panel>]
        );
    }
}

export default UserTable;