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
         <div className="tabs">
             <div className="tab-list">
                 <Tab>Add Municipality</Tab>
                 <Tab>Add Service</Tab>
                 <Tab>Link Municipality</Tab>
                 <Tab>List of Municipality and Services</Tab>
             </div>
             <div className="tab-progress"></div>
             <Panel> 
                 <div className ='municeForm'/>
                    <h1>Add needed districts</h1>
                    <form>
                        <div className="title">Name:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Name: e.target.value})}/>
                        </div>

                        <div className="title">State:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({State: e.target.value})}/>
                        </div>

                        <div className="title">Location:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Location: e.target.value})}/>
                        </div>

                        <div className="title">Email:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Email: e.target.value})}/>
                        </div>

                        <div className="button-container">
                        <button class="submit-button">Submit</button>
                </div>
                    </form>
             </Panel>
             <Panel>
             <div className ='serviceForm'/>
              <h1>Add services for districts here</h1>
                    <form>
                        <div className="title">Name:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Name: e.target.value})}/>
                        </div>

                        <div className="title">State:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({State: e.target.value})}/>
                        </div>

                        <div className="title">Location:</div>
                        <div className="infobox">
                          <input placeholder="" 
                              value="" 
                              onChange={e => ({Location: e.target.value})}/>
                        </div>

                        <div className="title">Service Type:</div>
                          <div className="dropbox">
                          <select id="serviceType" name="Service Type"> 
                          <option value="Fire">Fire</option>
                          <option value="Medical">Medical</option>
                          <option value="Police">Police</option>
                          </select>
                        </div>

                        <div className="button-container">
                        <button class="submit-button">Submit</button>
                    </div>
                  </form>
             </Panel>
                      <Panel>
                      <h1>Link the municipalities with specific services</h1>
                        <div className="title">Municipality:</div>
                          <div className="dropbox">
                          <select id="municeType" name="Munice Type"> 
                          <option value="Municipality 1">Municipality 1</option>
                          <option value="Municipality 2">Municipality 2</option>
                          <option value="Municipality 3">Municipality 3</option>
                          </select>
                        </div>

                        <div className="title">Police Services:</div>
                          <div className="dropbox">
                          <select id="policeService" name="Police Service"> 
                          <option value="police1">Police 1</option>
                          <option value="police2">Police 2</option>
                          <option value="police3">Police 3</option>
                          </select>
                        </div>

                        <div className="title">Fire Services:</div>
                          <div className="dropbox">
                          <select id="fireService" name="Fire Service"> 
                          <option value="Fire1">Fire 1</option>
                          <option value="Fire2">Fire 2</option>
                          <option value="Fire3">Fire 3</option>
                          </select>

                        <div className="title">EMS Services:</div>
                          <div className="dropbox">
                          <select id="emsService" name="EMS Service"> 
                          <option value="EMS1">EMS 1</option>
                          <option value="EMS2">EMS 2</option>
                          <option value="EMS3">EMS 3</option>
                          </select>
                        </div>

                        <div className="button-container">
                        <button class="submit-button">Submit</button>
                        </div>

                        </div>
                      </Panel>
             <Panel>
            <div className = "table">
             <table>
                <tr>
                  <th>Municipality</th>
                  <th>Fire Services</th>
                  <th>EMS Services</th>
                  <th>Police Services</th>
                </tr>
                <tr>
                  <td>Glassboro District</td>
                  <td>Glassboro Fire Department</td>
                  <td>Glassboro Medical Center</td>
                  <td>Glassboro Police Department</td>
                </tr>
                <tr>
                  <td>Willingbro District</td>
                  <td>Willingbro Fire Department</td>
                  <td>Willingbro Medical Center</td>
                  <td>Willingbro Poice Department</td>
                </tr>
                <tr>
                  <td>Camden District</td>
                  <td>Camden Fire Department</td>
                  <td>Camden Medical Center</td>
                  <td>Camden Poice Department</td>
                </tr>
            </table>
            </div>
             </Panel>
         </div>
     </Tabs>
 </div>
)

export default AdminPage;