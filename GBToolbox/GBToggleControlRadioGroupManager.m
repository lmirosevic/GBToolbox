//
//  GBToggleControlRadioGroupManager.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBToggleControlRadioGroupManager.h"

#import "GBToggleControl.h"

@implementation GBToggleControlRadioGroupManager

#pragma mark - ca

-(void)dealloc {
    //must do this to remove old targets
    self.toggleControls = nil;
}

-(void)setToggleControls:(NSArray *)toggleControls {
    //if they're not all toggle controls, then throw exception
    for (id object in toggleControls) {
        if (![object isKindOfClass:GBToggleControl.class]) {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Must pass in an array of GBToggleControls" userInfo:nil];
        }
    }
    
    //make sure to remove self as target from old controls
    for (GBToggleControl *toggle in _toggleControls) {
        [toggle removeTarget:self action:@selector(toggleAction:) forControlEvents:UIControlEventValueChanged];
    }

    //add self as target for new controls
    for (GBToggleControl *toggle in toggleControls) {
        [toggle addTarget:self action:@selector(toggleAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    _toggleControls = toggleControls;
}

-(void)setSelectedControl:(GBToggleControl *)selectedControl {
    [self _selectControl:selectedControl];
}

-(void)setSelectedControlIndex:(NSInteger)selectedControlIndex {
    [self _selectControlWithIndex:selectedControlIndex];
}

#pragma mark - API

-(void)deselectAllControls {
    [self _resetState];
}

#pragma mark - util

-(void)_resetState {
    for (GBToggleControl *toggle in self.toggleControls) {
        toggle.isOn = NO;
    }
    
    _selectedControlIndex = -1;
    _selectedControl = nil;
    
    //tell delegate
    if ([self.delegate respondsToSelector:@selector(toggleControlRadioGroupManagerDidResetSelection:)]) {
        [self.delegate toggleControlRadioGroupManagerDidResetSelection:self];
    }
}

-(void)_selectControl:(GBToggleControl *)control {
    //find the index
    NSUInteger index = [self.toggleControls indexOfObject:control];
    [self _selectControlWithIndex:index];
}

-(void)_selectControlWithIndex:(NSUInteger)index {
    if (index == NSNotFound) {
        NSLog(@"Warning: trying to select control which has not been added to the GBRadioToggleControlsManager");
    }
    else if (index >= self.toggleControls.count) {
        NSLog(@"Warning: trying to select control whose index is out of bounds of the controls added to the GBRadioToggleControlsManager");
    }
    else {
        //select my control and deselect all the other ones
        for (NSUInteger i=0; i<self.toggleControls.count; i++) {
            GBToggleControl *toggle = self.toggleControls[i];
            
            //select target control
            if (i == index) {
                toggle.isOn = YES;
                
                _selectedControlIndex = i;
                _selectedControl = toggle;
            }
            //deselect all others
            else {
                toggle.isOn = NO;
            }
        }
        
        //tell delegate
        if ([self.delegate respondsToSelector:@selector(toggleControlRadioGroupManager:didSelectToggleControl:withIndex:)]) {
            [self.delegate toggleControlRadioGroupManager:self didSelectToggleControl:self.selectedControl withIndex:self.selectedControlIndex];
        }
    }
}

#pragma mark - action

-(void)toggleAction:(GBToggleControl *)sender {
    //doesn't matter what state he toggled himself into, we're overriding it
    [self _selectControl:sender];
}

@end
