import React from 'react';
import { Tabs, useTabState, Panel } from "@bumaga/tabs";

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

const AdminPage = () => (
 <div className="adminpage">
     <Tabs>
         <div class="tabs">
             <div class="tab-list">
                 <Tab>Add Municipality</Tab>
                 <Tab>Add Service</Tab>
                 <Tab>List of Municipality and Services</Tab>
             </div>
             <div class="tab-progress"></div>
             <Panel> 
                 <div classname ='municeForm'/>
                    <h1>Add needed districts</h1>
                    <form>
                        <div class="title">Area:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Area: e.target.value})}/>
                        </div>

                        <div class="title">Medical:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Medical: e.target.value})}/>
                        </div>

                        <div class="title">Police:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Police: e.target.value})}/>
                        </div>

                        <div class="title">Fire Services:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Fire: e.target.value})}/>
                        </div>

                        <div class="button-container">
                        <button class="submit-button">Submit</button>
                </div>
                    </form>
             </Panel>
             <Panel>
             <h1>Add services for districts here</h1>
                    <form>
                        <div class="title">Area:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Area: e.target.value})}/>
                        </div>

                        <div class="title">Medical:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Medical: e.target.value})}/>
                        </div>

                        <div class="title">Police:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Police: e.target.value})}/>
                        </div>

                        <div class="title">Fire Services:</div>
                        <div class="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Fire: e.target.value})}/>
                        </div>

                        <div class="button-container">
                        <button class="submit-button">Submit</button>
                </div>
                    </form>
             </Panel>
             <Panel> INSERT LIST HERE</Panel>
         </div>
     </Tabs>
 </div>
)

export default AdminPage;