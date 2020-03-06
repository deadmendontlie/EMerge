import React from 'react';
import { Tabs, useTabState, Panel, usePanelState } from "@bumaga/tabs";
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

const HomePage = () => (
    <div className='homepage'>
        <Tabs>
            <div class="tabs">
                <div class="tab-list">
                    <Tab>Incoming</Tab>
                    <Tab>Acknowledged</Tab>
                    <Tab>Solved</Tab>
                </div>
                <div class="tab-progress"></div>
                <Panel>
                    <div class="container row">
                        <div class="information-container">
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
                        <div class="button-container">
                        <button class="acknowledge-button">Acknowledge</button>
                        </div>
                    </div>
                    <div class="container row">
                        <div class="information-container">
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
                        <div class="button-container">
                        <button class="acknowledge-button">Acknowledge</button>
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

export default HomePage;