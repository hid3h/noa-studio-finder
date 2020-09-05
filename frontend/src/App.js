import React, { useState } from 'react';
import 'antd/dist/antd.css';
import './App.css';

import Axios from 'axios'

import { Layout, Table } from 'antd';
import { Button } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

const { Footer, Content } = Layout;

const apiBaseUrl = process.env.NODE_ENV === 'production' ? 'https://ponest.net/api/v1' : 'http://127.0.0.1:2002/api/v1'
const axios = Axios.create({
  baseURL: apiBaseUrl
})

const title = "ノアスタジオかんたん検索(非公式)"

function App() {
  const [loading, setLoading] = useState(false)
  const [columns, setColumns] = useState([])
  const [dataSource, setDataSource] = useState([])


  function search() {
    setLoading(true)
    axios.get('/studios')
    .then((res) => {
      console.log('res', res)

      const tempColumns = []
      const tempdataSource = []
      Object.keys(res.data).map((key) => {
        const studio = res.data[key]
        console.log('studio', studio)
        tempColumns.push({
          title: studio["web_branch_name"] + studio["studio_name"],
          key: key // studio_id    
        })
      })
      setColumns(tempColumns)
    })
  }

  // const columns = [
  //   {
  //     title: 'Name',
  //     dataIndex: 'name',
  //     key: 'name',
  //   },
  //   {
  //     title: 'Age',
  //     dataIndex: 'age',
  //     key: 'age',
  //   },
  //   {
  //     title: 'Address',
  //     dataIndex: 'address',
  //     key: 'address',
  //   },
  // ];

  // const dataSource = [
  //   {
  //     key: '1',
  //     name: 'Mike',
  //     age: 32,
  //     address: '10 Downing Street',
  //   },
  //   {
  //     key: '2',
  //     name: 'John',
  //     age: 42,
  //     address: '10 Downing Street',
  //   },
  // ];

  return (
    <>
      <Layout>
        <h1>{title}</h1>
        <Content>
          <div>
            <Button type="primary" icon={<SearchOutlined />} size='large' loading={loading} onClick={search}>
              スタジオ検索
            </Button>
          </div>
          <div>
            <Table dataSource={dataSource} columns={columns} />;
          </div>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </>
  );
}

export default App;
