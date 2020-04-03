import React from 'react';
import { Tabs, useTabState, Panel } from "@bumaga/tabs";
import "./homepage.styles.scss";

const cn = (...args) => args.filter(Boolean).join(' ')

const Tab = ({ children }) => {
  const { isActive, onClick } = useTabState()

  return (
    <button className={cn('tab', isActive && 'active')} onClick={onClick}>
      {children}
    </button>
  )
}

class HomePage extends React.Component {
    state = {
        loading: true
    };

    async componentDidMount() {
        
    const myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");
    
    const raw = JSON.stringify(
    {
        "report_id":1
    });
    
    const requestOptions = {
      method: 'POST',
      headers: myHeaders,
      body: raw,
      redirect: 'follow'
    };
    
    await fetch("http://18.212.156.43:80/get_report", requestOptions)
      .then(response => response.text())
      .then(result => console.log(result))
      .catch(error => console.log('error', error));
     }

     async componentDidUpdate() {
      
        const url= "18.212.156.43:80/get_report";
        const response = await fetch(url);
        const data = await response.json();
        console.log(data);
     }

    render(){
    return(
    <div className='homepage'>
        <Tabs>
            <div className="tabs">
                <div className="tab-list">
                    <Tab>Incoming</Tab>
                    <Tab>Acknowledged</Tab>
                    <Tab>Solved</Tab>
                </div>
                <div className="tab-progress"></div>
                <Panel>
                    <div className="container row">
                        <div className="information-container">
                        <p>
                        Description: A man has fallin into a river in the city...
                        </p>
                        <p>
                        Time Submitted: April 7th, 2020 1:47PM
                        </p>
                        <p>
                        Location: 1234 Fake Street, Glassboro, NJ 08028
                        </p>
                        </div>
                        <div className="button-container">
                        <button className="acknowledge-button">Acknowledge</button>
                        </div>
                    </div>
                    <div className="container row">
                        <div className="information-container">
                        <p>
                        Description: There is a fire at Wawa...
                        </p>
                        <p>
                        Time Submitted: April 7th, 2020 1:49PM
                        </p>
                        <p>
                        Location: 352 Wawa Drive, Glassboro, NJ 08028
                        </p>
                        </div>
                        <div className="button-container">
                        <button className="acknowledge-button">Acknowledge</button>
                        </div>
                    </div>
                </Panel>

                <Panel>
                    <p>
                    INPUT ACKNOWLEDGED TABLE HERE
                    </p>
                </Panel>

                <Panel>
                    <p>
                    INPUT SOLVED TABLE HERE
                    </p>
                </Panel>
            </div>
        </Tabs>
    </div>
    )
    }
}

export default HomePage;