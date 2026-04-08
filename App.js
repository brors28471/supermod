import React, { useState } from 'react';
import { StyleSheet, View, TouchableOpacity, Text, Modal, ScrollView } from 'react-native';
import { WebView } from 'react-native-webview';
import { StatusBar } from 'expo-status-bar';

export default function App() {
  const [showMenu, setShowMenu] = useState(false);
  const [selectedMenu, setSelectedMenu] = useState(null);
  const [selectedTab, setSelectedTab] = useState(0);

  const menuItems = [
    { name: 'Gameplay', color: null },
    { name: 'Zoom', color: '#ff0000' },
    { name: 'Macro', color: null },
    { name: 'Mastersplit', color: '#800080' },
    { name: 'Map', color: '#008000' }
  ];

  const tabs = {
    'Gameplay': ['Speed', 'Behavior', 'Visual'],
    'Zoom': ['Level', 'Smooth', 'Auto'],
    'Macro': ['Split', 'Feed', 'Eject'],
    'Mastersplit': ['Mode', 'Speed', 'Advanced'],
    'Map': ['Style', 'Size', 'Opacity']
  };

  const settings = {
    'Gameplay': {
      0: [['Movement Speed', '1.2x'], ['Acceleration', '0.8x'], ['Deceleration', '0.9x']],
      1: [['Auto Eject', 'Enabled'], ['Auto Split', 'Disabled'], ['Collision Detection', 'On']],
      2: [['Show Grid', 'On'], ['Show Names', 'On'], ['Particle Effects', 'High']]
    },
    'Zoom': {
      0: [['Zoom Level', '1.0x'], ['Min Zoom', '0.5x'], ['Max Zoom', '3.0x']],
      1: [['Smooth Zoom', 'Enabled'], ['Zoom Speed', '0.5s'], ['Follow Player', 'On']],
      2: [['Auto Zoom', 'Enabled'], ['Zoom on Split', 'On'], ['Zoom Sensitivity', 'Medium']]
    },
    'Macro': {
      0: [['Split Delay', '50ms'], ['Split Speed', 'Fast'], ['Multi Split', 'Enabled']],
      1: [['Feed Delay', '30ms'], ['Feed Amount', '10'], ['Auto Feed', 'Disabled']],
      2: [['Eject Delay', '40ms'], ['Eject Power', 'High'], ['Eject Direction', 'Auto']]
    },
    'Mastersplit': {
      0: [['Split Mode', 'Sequential'], ['Split Pattern', 'Optimal'], ['Merge Detection', 'On']],
      1: [['Split Frequency', '2.0x'], ['Reaction Time', '100ms'], ['Burst Mode', 'Enabled']],
      2: [['AI Prediction', 'On'], ['Threat Detection', 'High'], ['Escape Mode', 'Enabled']]
    },
    'Map': {
      0: [['Map Theme', 'Dark'], ['Grid Style', 'Dots'], ['Border Color', 'White']],
      1: [['Map Scale', '1.0x'], ['Cell Size', 'Medium'], ['Minimap Size', 'Large']],
      2: [['Map Opacity', '80%'], ['Grid Opacity', '50%'], ['Player Indicator', '100%']]
    }
  };

  return (
    <View style={styles.container}>
      <WebView 
        source={{ uri: 'https://agar.io' }}
        style={styles.webview}
      />
      
      {!showMenu && (
        <TouchableOpacity 
          style={styles.menuButton}
          onPress={() => setShowMenu(true)}
        >
          <Text style={styles.menuButtonText}>⚙️</Text>
        </TouchableOpacity>
      )}

      <Modal
        visible={showMenu}
        transparent={true}
        animationType="fade"
      >
        <View style={styles.modalOverlay}>
          <View style={styles.menuContainer}>
            {!selectedMenu ? (
              <>
                <View style={styles.header}>
                  <Text style={styles.headerText}>@dtje029</Text>
                  <TouchableOpacity onPress={() => setShowMenu(false)}>
                    <Text style={styles.closeButton}>✕</Text>
                  </TouchableOpacity>
                </View>
                
                <ScrollView>
                  {menuItems.map((item, index) => (
                    <TouchableOpacity
                      key={index}
                      style={styles.menuItem}
                      onPress={() => {
                        setSelectedMenu(item.name);
                        setSelectedTab(0);
                      }}
                    >
                      {item.color && (
                        <View style={[styles.indicator, { backgroundColor: item.color }]} />
                      )}
                      <Text style={styles.menuItemText}>{item.name}</Text>
                      <Text style={styles.arrow}>›</Text>
                    </TouchableOpacity>
                  ))}
                </ScrollView>
              </>
            ) : (
              <>
                <View style={styles.header}>
                  <TouchableOpacity onPress={() => setSelectedMenu(null)}>
                    <Text style={styles.backButton}>‹ {selectedMenu}</Text>
                  </TouchableOpacity>
                  <TouchableOpacity onPress={() => {
                    setSelectedMenu(null);
                    setShowMenu(false);
                  }}>
                    <Text style={styles.closeButton}>✕</Text>
                  </TouchableOpacity>
                </View>

                <View style={styles.tabContainer}>
                  {tabs[selectedMenu].map((tab, index) => (
                    <TouchableOpacity
                      key={index}
                      style={[styles.tab, selectedTab === index && styles.activeTab]}
                      onPress={() => setSelectedTab(index)}
                    >
                      <Text style={[styles.tabText, selectedTab === index && styles.activeTabText]}>
                        {tab}
                      </Text>
                    </TouchableOpacity>
                  ))}
                </View>

                <ScrollView style={styles.settingsContainer}>
                  {settings[selectedMenu][selectedTab].map((setting, index) => (
                    <View key={index} style={styles.settingRow}>
                      <Text style={styles.settingLabel}>{setting[0]}</Text>
                      <Text style={styles.settingValue}>{setting[1]}</Text>
                    </View>
                  ))}
                </ScrollView>
              </>
            )}
          </View>
        </View>
      </Modal>

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  webview: {
    flex: 1,
  },
  menuButton: {
    position: 'absolute',
    bottom: 20,
    right: 20,
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: '#00bcd4',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 5,
    elevation: 5,
  },
  menuButtonText: {
    fontSize: 24,
    color: '#fff',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.3)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  menuContainer: {
    width: '100%',
    maxWidth: 400,
    maxHeight: '80%',
    backgroundColor: '#333',
    borderRadius: 12,
    overflow: 'hidden',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#2a2a2a',
  },
  headerText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
  },
  backButton: {
    color: '#fff',
    fontSize: 18,
  },
  closeButton: {
    color: '#fff',
    fontSize: 24,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#444',
  },
  indicator: {
    width: 20,
    height: 20,
    borderRadius: 10,
    marginRight: 12,
  },
  menuItemText: {
    flex: 1,
    color: '#fff',
    fontSize: 16,
  },
  arrow: {
    color: '#fff',
    fontSize: 20,
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: '#3a3a3a',
    padding: 8,
  },
  tab: {
    flex: 1,
    padding: 8,
    alignItems: 'center',
  },
  activeTab: {
    backgroundColor: '#555',
    borderRadius: 4,
  },
  tabText: {
    color: '#999',
    fontSize: 14,
  },
  activeTabText: {
    color: '#fff',
  },
  settingsContainer: {
    padding: 16,
  },
  settingRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 12,
    backgroundColor: '#2a2a2a',
    borderRadius: 6,
    marginBottom: 8,
  },
  settingLabel: {
    color: '#fff',
    fontSize: 14,
  },
  settingValue: {
    color: '#999',
    fontSize: 14,
  },
});
