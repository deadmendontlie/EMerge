import React from 'react';
import { Tabs, useTabState, Panel } from "@bumaga/tabs";
import axios from 'axios';


import './adminpage.styles.scss';

const cn = (...args) => args.filter(Boolean).join(' ')

const Tab = ({ children }) => {
	const { isActive, onClick } = useTabState()

	return (
		<button className={cn('tab', isActive && 'active')} onClick={onClick}>
			{children}
		</button>
	)
}

//Adds a new municipality to the database using the data from the textboxes on the website
function addMuni(name, state, location, email) {
	axios.put('http://18.212.156.43/add_muni', {
		name: name,
		state: state,
		GPS_coord: location,
		email: email
		})
		.then((response) => {
			console.log(response);
		  }, (error) => {
			console.log(error);
		  })
}

//Adds a new service to a certain municipality using the data from the textboxes and dropdowns
//on the website
function addEmerService(name, service_type, municipality_id) {
	axios.put('http://18.212.156.43/add_emer_service', {
		name: name,
		service_type: service_type,
		municipality_id: municipality_id
		})
		.then((response) => {
			console.log(response);
		  }, (error) => {
			console.log(error);
		  })
}

//Creates the body of the admin page which gives the logged in user the ability to:
//	sign up a new user
//	add a new municipality
//	add a new service to a municipality
//	see all the current municipalities in the database
class AdminPage extends React.Component {
	state = {
		name: '',
		state: '',
		GPS_coord: '',
		email: '',
		service: '',
		service_type: '',
		municipality_id: '',
		muni : []
	}

	//Returns all the municipalities to fill out some information on the admin page
	componentDidMount() {
        axios.get('http://18.212.156.43/get_all_muni')
            .then((response) => {
                console.log(response.data);
                const muni = response.data;
                this.setState({ muni });
              }, (error) => {
                console.log(error);
              })
    }
	
	//Creates the admin page and fills out information where needed
	render() {
		const municipalities = this.state.muni.map(function(item) {
			return <option value={item.municipality_id}>{item.name}</option>
		})

		const munilist = this.state.muni.map(function(item) {
			return <tr>{item.name}</tr>
		})

		return (
			<div className="adminpage">
				<Tabs>
					<div className="tabs">
						<div className="tab-list">
							<Tab>Add Municipality</Tab>
							<Tab>Add Service</Tab>
							<Tab>List of Municipality and Services</Tab>
						</div>
						<div className="tab-progress"></div>
						<Panel>
							<div className='municeForm' />
								<div className="title">Name:</div>
								<div className="infobox">
									<input name="name" onChange={e => this.setState({ name: e.target.value })} />
								</div>

								<div className="title">State:</div>
								<div className="infobox">
									<input name="state" onChange={e => this.setState({ state: e.target.value })} />
								</div>

								<div className="title">Location:</div>
								<div className="infobox">
									<input name="GPS_coord" onChange={e => this.setState({ GPS_coord: e.target.value })} />
								</div>

								<div className="title">Email:</div>
								<div className="infobox">
									<input name="email" onChange={e => this.setState({ email: e.target.value })} />
								</div>

								<div className="button-container">
									<button onClick={() => addMuni(this.state.name, this.state.state, this.state.GPS_coord, this.state.email)} className="submit-button">Submit</button>
								</div>
						</Panel>
						<Panel>
							<div className='serviceForm' />
								<div className="title">Name:</div>
								<div className="infobox">
									<input onChange={e => this.setState({ name: e.target.value })} />
								</div>

								<div className="title">Service Type:</div>
								<div className="dropbox">
									<select id="serviceType" name="Service Type">
										<option value="Fire">Fire</option>
										<option value="Medical">Hospital</option>
										<option value="Police">Police</option>
									</select>
								</div>

								<div className="title">Municipality:</div>
								<div className="dropbox">
									<select id="municipality_id" name="municipality_id">
										{municipalities}
									</select>
								</div>

								<div className="button-container">
									<button onClick={() => addEmerService(this.state.name, this.state.service_type, this.state.municipality_id)} className="submit-button">Submit</button>
								</div>
						</Panel>
						<Panel>
						<div className="table">
							<table>
								<thead>
									<tr>
										<td>Municipality Name</td>
									</tr>
								</thead>
								<tbody>
									{munilist}
								</tbody>
							</table>
						</div>
							
						</Panel>
					</div>
				</Tabs>
			</div>
		)
	}
}

export default AdminPage;