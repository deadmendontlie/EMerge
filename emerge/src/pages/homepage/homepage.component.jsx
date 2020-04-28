import React from 'react';
import { Tabs, useTabState } from "@bumaga/tabs";
import "./homepage.styles.scss";
import UserTable from '../../components/tables/usertable.component'


const cn = (...args) => args.filter(Boolean).join(' ')

const Tab = ({ children }) => {
	const { isActive, onClick } = useTabState()

	return (
		<button className={cn('tab', isActive && 'active')} onClick={onClick}>
			{children}
		</button>
	)
}


//Creates homepage body using the logged in user's email to find its municipality_id to pass it to the UserTable
class HomePage extends React.Component {
	
	render() {
		return (
			<div className='homepage'>
				<Tabs>
					<div className="tabs">
						<div className="tab-list">
							<Tab>Incoming</Tab>
							<Tab>Acknowledged</Tab>
							<Tab>Solved</Tab>
						</div>
						<div className="tab-progress"></div>
						<UserTable  municipality_id={this.props.municipality_id} /> 
					</div>
				</Tabs>
			</div>
		)
	}
}

export default HomePage;